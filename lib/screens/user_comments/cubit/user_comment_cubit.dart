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

  // late List<CommentModel> resultList = [];
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
              status: UserCommentStatus.success, listCommModel: commentList),
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


}
