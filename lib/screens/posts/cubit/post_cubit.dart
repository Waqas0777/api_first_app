import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:api_first_app/model/post_model.dart';
import 'package:api_first_app/model/shared_preferences_model.dart';
import 'package:api_first_app/screens/user_todos/cubit/user_todos_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../../../model/todos_model.dart';
import '../../user_posts/cubit/user_posts_cubit.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState());
  var postModel = PostModel();
  late List<PostModel> postList = [];
  late List<PostModel> resultList = [];
  late List<TodosModel> todosList = [];
  late List<TodosModel> todosResultList = [];
  late String? user;
  static const int timeOutDuration = 5;

  //https://jsonplaceholder.typicode.com/posts all posts
  //https://jsonplaceholder.typicode.com/users/2/posts specific id posts

//fetching specific user post by user id
  Future<List<PostModel>> fetchPostsById(int id) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final response = await http
          .get(Uri.parse(
              'https://jsonplaceholder.typicode.com/users/' "$id" '/posts'))
          .timeout(const Duration(seconds: timeOutDuration));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<PostModel> postModel = (json.decode(response.body) as List)
            .map((data) => PostModel.fromJson(data))
            .toList();
        log(postModel.length.toString());

        postList.clear();
        for (var element in body) {
          PostModel postModel = PostModel(
              userId: element["userId"],
              id: element["id"],
              title: element["title"],
              body: element["body"]);
          postList.add(postModel);
        }

        log(postModel.length.toString(), name: "postModel");

        // onSearchById(
        //     getIt<SharedPreferencesModel>().getLoginId("userId").toInt())
        //     .then((value) => {
        //   if (value.isNotEmpty)
        //     {
        //       emit(
        //         state.copyWith(
        //             status: UserStatus.success, listPostModel: value),
        //       )
        //     }
        //   else
        //     {
        //       emit(
        //         state.copyWith(status: UserStatus.failure),
        //       )
        //     }
        // });

        emit(
          state.copyWith(status: UserStatus.success, listPostModel: postList),
        );

        //user = body.toString();
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
    }
  }

//fetching specific user todos by user id
  Future<List<PostModel>> fetchTodosById(int id) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final response = await http
          .get(Uri.parse(
              'https://jsonplaceholder.typicode.com/users/' "$id" '/todos'))
          .timeout(const Duration(seconds: timeOutDuration));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<TodosModel> todosModel = (json.decode(response.body) as List)
            .map((data) => TodosModel.fromJson(data))
            .toList();
        log(todosModel.length.toString());

        todosList.clear();
        for (var element in body) {
          TodosModel todosModel = TodosModel(
              userId: element["userId"],
              id: element["id"],
              title: element["title"],
              completed: element["completed"]);
          todosList.add(todosModel);
        }

        log(todosModel.length.toString(), name: "todosModel");

        // onSearchById(
        //     getIt<SharedPreferencesModel>().getLoginId("userId").toInt())
        //     .then((value) => {
        //   if (value.isNotEmpty)
        //     {
        //       emit(
        //         state.copyWith(
        //             status: UserStatus.success, listPostModel: value),
        //       )
        //     }
        //   else
        //     {
        //       emit(
        //         state.copyWith(status: UserStatus.failure),
        //       )
        //     }
        // });

        emit(
          state.copyWith(status: UserStatus.success, listTodosModel: todosList),
        );

        //user = body.toString();
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
    }
  }

  //fetching all posts
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
        postList.clear();
        for (var element in body) {
          PostModel postModel = PostModel(
              userId: element["userId"],
              id: element["id"],
              title: element["title"],
              body: element["body"]);
          postList.add(postModel);
        }

        log(postModel.length.toString(), name: "postModel");

        onSearchById(
                getIt<SharedPreferencesModel>().getLoginId("userId").toInt())
            .then((value) => {
                  if (value.isNotEmpty)
                    {
                      emit(
                        state.copyWith(
                            status: UserStatus.success, listPostModel: value),
                      )
                    }
                  else
                    {
                      emit(
                        state.copyWith(status: UserStatus.failure),
                      )
                    }
                });

        emit(
          state.copyWith(status: UserStatus.success, listPostModel: postList),
        );

        //user = body.toString();
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

// search on specific field id
  Future<List<PostModel>> onSearchById(int id) async {
    //log(value, name: "value");
    try {
      List<PostModel> filteredItems =
          postList.where((item) => item.userId == id).toList();
      log("${filteredItems.length} ", name: "filteredItems");
      log("${postList.length} ", name: "postList");

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
      emit(state.copyWith(
          status: UserStatus.success, listPostModel: filteredItems));
      log("$state", name: "state");
      return resultList;
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
  }

  //search on  model
  Future<List<PostModel>> onSearch(String searchQuery) async {
    //log(value, name: "value");
    List<PostModel> filteredItems = postList
        .where((item) => item
            .toJson()
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
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
    emit(state.copyWith(
        status: UserStatus.searchingStatus, listPostModel: filteredItems));
    log("$state", name: "state");
    return resultList;
  }

  onLogoutClicked() {
    // postList.clear();
    // resultList.clear();
    // getIt<UserTodosCubit>().todosList.clear();
    // getIt<UserPostsCubit>().postList.clear();
    getIt<SharedPreferencesModel>().setLoginId(0);
    emit(
      state.copyWith(
        status: UserStatus.initial,
      ),
    );
  }
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
