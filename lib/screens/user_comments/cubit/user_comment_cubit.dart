import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '../../../model/comment_model.dart';

part 'user_comment_state.dart';

class UserCommentCubit extends Cubit<UserCommentState> {
  UserCommentCubit() : super(const UserCommentState());
  var comModel = CommentModel();
  late List<CommentModel> commentList = [];

  late List<CommentModel> resultList = [];
  late String? user;
  static const int timeOutDuration = 5;

  //https://jsonplaceholder.typicode.com/comments
  Future<List<CommentModel>> fetchComments() async {
    emit(state.copyWith(status: UserCommentStatus.loading));

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'))
          .timeout(const Duration(seconds: timeOutDuration));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        log("$body", name: "bodyy");
        List<CommentModel> commModel = (json.decode(response.body) as List)
            .map((data) => CommentModel.fromJson(data))
            .toList();

        for (var element in body) {
          CommentModel commentModel = CommentModel(
            postId: element["postId"],
            id: element["id"],
            name: element["name"],
            email: element["email"],
            body: element["body"],
          );
          commentList.add(commentModel);
        }
        emit(
          state.copyWith(
              status: UserCommentStatus.success, comModel: commentList),
        );
        // user = body.toString();
        log("$commentList", name: "commentList");
        return commentList;
      } else {
        emit(
          state.copyWith(
            status: UserCommentStatus.failure,
          ),
        );
        throw Exception("Failed to load post");
      }
    } on SocketException {
      emit(
        state.copyWith(
          status: UserCommentStatus.socketStatus,
        ),
      );
      // Handle socket exception
      return Future.error("No Internet Connection");
    } on TimeoutException {
      emit(
        state.copyWith(
          status: UserCommentStatus.timeoutStatus,
        ),
      );
      // Handle timeout exception
      return Future.error("Request Timeout Exception");
    } on http.ClientException {
      emit(
        state.copyWith(
          status: UserCommentStatus.userStatus,
        ),
      );
      // Handle client/server exception
      return Future.error("App Crashed due to some user mobile");
    } catch (e) {
      return Future.error("Something Went Wrong");
    }
    // on Exception catch (exception) {
    //   emit(
    //     state.copyWith(
    //       status: UserStatus.failure,
    //       exception: exception,
    //     ),
    //   );
    //   return "Error";
    // }
  }



  Future<List<CommentModel>> filterCommentsByEmail(String email)async {
    log("call",name:"call");
    emit(state.copyWith(status: UserCommentStatus.loading));

    List<CommentModel> filteredComments = commentList.where((comment) => comment.email == email).toList();
    log("$filteredComments", name: "filteredComments");
    emit(state.copyWith(
        status: UserCommentStatus.success, comModel: filteredComments));
    return  filteredComments;

  }

  //search on specific field
  Future<List<CommentModel>> onSearch(String searchQuery) async {
    //log(value, name: "value");
    List<CommentModel> filteredItems = commentList
        .where((item) =>
            item.email!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    for (var element in filteredItems) {
      log("${element.email}", name: "element");
      //log("${filteredItems} $searchQuery", name: "filteredItems");
      CommentModel comModel = CommentModel(
          postId: element.postId,
          id: element.id,
          name: element.name,
          email: element.email,
          body: element.body);
      resultList.add(comModel);
    }
    emit(state.copyWith(
        status: UserCommentStatus.success, comModel: filteredItems));
    log("$state", name: "state");
    return resultList;
  }


// Future<void> fetchCommentsByEmail(String email) async {
//   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments?email=$email'));
//   if (response.statusCode == 200) {
//     final List<dynamic> data = jsonDecode(response.body);
//     final List<Comment> comments = data.map((comment) => Comment.fromJson(comment)).toList();
//     emit(CommentsLoaded(comments));
//   } else {
//     // Handle errors here
//   }
// }

}
