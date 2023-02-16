import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:api_first_app/model/post_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState());
  var postModel = PostModel();
  late List<PostModel> postList = [];
  late List<PostModel> resultList = [];
  late String? user;
  static const int timeOutDuration = 5;

  //https://jsonplaceholder.typicode.com/posts

  Future<List<PostModel>> fetchPosts() async {
    emit(state.copyWith(status: UserStatus.loading));

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
          .timeout(const Duration(seconds: timeOutDuration));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        //log("$body", name: "body");
        List<PostModel> postModel = (json.decode(response.body) as List)
            .map((data) => PostModel.fromJson(data))
            .toList();
        log(postModel.length.toString());

        postModel[0];
        for (var element in body) {
          PostModel postModel = PostModel(
              userId: element["userId"],
              id: element["id"],
              title: element["title"],
              body: element["body"]);
          postList.add(postModel);
          // log("${element.body[0]}");
          // log("registered list=${element}");
          //postList.add(PostModel());
          //log($postModel.length, name: "body");
        }
        emit(
          state.copyWith(status: UserStatus.success, pModel: postList),
        );
        user = body.toString();
        return postList;
      } else {
        emit(
          state.copyWith(
            status: UserStatus.failure,
          ),
        );
        throw Exception("Failed to load post");
      }
    } on SocketException {
      emit(
        state.copyWith(
          status: UserStatus.socketStatus,
        ),
      );
      // Handle socket exception
      return Future.error("No Internet Connection");
    } on TimeoutException {
      emit(
        state.copyWith(
          status: UserStatus.timeoutStatus,
        ),
      );
      // Handle timeout exception
      return Future.error("Request Timeout Exception");
    } on http.ClientException {
      emit(
        state.copyWith(
          status: UserStatus.userStatus,
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

  //search on specific field
  // Future<List<PostModel>> onSearch(String searchQuery) async {
  //   //log(value, name: "value");
  //   List<PostModel> filteredItems = postList
  //       .where((item) =>
  //           item.title!.toLowerCase().contains(searchQuery.toLowerCase()))
  //       .toList();
  //   for (var element in filteredItems) {
  //     log("${element.title}", name: "element");
  //     //log("${filteredItems} $searchQuery", name: "filteredItems");
  //     PostModel postModel = PostModel(
  //         userId: element.userId,
  //         id: element.id,
  //         title: element.title,
  //         body: element.body);
  //     resultList.add(postModel);
  //   }
  //   emit(
  //       state.copyWith(status: UserStatus.searchingStatus, pModel: filteredItems));
  //   log("$state", name: "state");
  //   return resultList;
  // }

  //search on  model
  Future<List<PostModel>> onSearch(String searchQuery) async {
    //log(value, name: "value");
    List<PostModel> filteredItems = postList
        .where((item) =>
        item.toJson().toString().toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    for (var element in filteredItems) {
      log("${element.title}", name: "element");
      //log("${filteredItems} $searchQuery", name: "filteredItems");
      PostModel postModel = PostModel(
          userId: element.userId,
          id: element.id,
          title: element.title,
          body: element.body);
      resultList.add(postModel);
    }
    emit(
        state.copyWith(status: UserStatus.searchingStatus, pModel: filteredItems));
    log("$state", name: "state");
    return resultList;
  }
}














//chat gpt search api https://jsonplaceholder.typicode.com/posts
// Future<List<PostModel>> fetchSearchResults(String query) async {
//   final response =
//       await http.get(Uri.parse('https://example.com/api/search?q=$query'));
//
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     List<PostModel> items =
//         List<PostModel>.from(data.map((item) => PostModel.fromJson(item)));
//     return items;
//   } else {
//     throw Exception('Failed to fetch search results');
//   }
// }
// }
// Future<List<PostModel>> onSearchPost(String value) async {
//   List<PostModel> searchList = [];
//
//   postList.forEach((user) {
//     //|| user.last.toLowerCase().contains(searchQuery.toLowerCase())
//     if (user.title!.toLowerCase().contains(value.toLowerCase())) {
//       postList.add(user);
//     }
//   });
//   searchList = postList
//       .where((postModel) => postModel.title!.toLowerCase().contains(value))
//       .toList();
//   // List<PostModel> postModel = BlocProvider.of<PostCubit>(context).postList;
//   emit(
//     state.copyWith(status: UserStatus.success, pModel: postList),
//   );
//   return searchList;
// }

// Future<List<PostModel>> onSearchPost(String searchQuery) async {
//
//   List<PostModel> filteredItems = postList
//       .where((item) =>
//           item.title!.toLowerCase().contains(searchQuery.toLowerCase()))
//       .toList();
//   emit(
//     state.copyWith(status: UserStatus.filtered, pModel: postList),
//   );
//   return filteredItems;
// }
