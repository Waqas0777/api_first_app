import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../database/db/app_database.dart';
import '../../../main.dart';
import '../../../model/post_model.dart';
import 'package:http/http.dart' as http;
import '../../../model/shared_preferences_model.dart';

part 'user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  UserPostsCubit() : super(const UserPostsState());

  //var postModel = PostModel();
  late List<PostModel> postList = [];
 // late List<PostModel> resultList = [];
  late List<UserPostTableData> userPostTableData = [];

  late String? user;
  static const int timeOutDuration = 5;

  // Define a method to handle the back press
  void handleBackPress() {
    emit(
      state.copyWith(
        status: UserPostsStatus.initial,
      ),
    );
  }

  Future<Object?> fetchPostsById(int id) async {
    log("fetchPostsById");

    emit(state.copyWith(status: UserPostsStatus.loading));
    var checkPostApiCall = getIt<SharedPreferencesModel>().getUserPostsApiCallStatus();
    log('$checkPostApiCall', name: "checkApiCallPosts");
    if (checkPostApiCall) {
      List<UserPostTableData>? list = getAllPostsById(id);
      return list;
    } else {
      try {
        final response = await http
            .get(Uri.parse(
                'https://jsonplaceholder.typicode.com/users/' "$id" '/posts'))
            .timeout(                                                                                                                       const Duration(seconds: timeOutDuration));
        if (response.statusCode == 200) {
          log('${response.statusCode}', name: "statusCode");
          log('$checkPostApiCall', name: "checkApiCall");
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
                body: element["body"],);
            postList.add(postModel);
          }
          await getIt<AppDatabase>().userPostTableDao.insertPosts(postList);
          int id = getIt<SharedPreferencesModel>().getLoginId("userId");

          List<UserPostTableData>? dbList = getAllPostsById(id);

          emit(
            state.copyWith(
                status: UserPostsStatus.success, listUserPostTableData: dbList),
          );

          //user = body.toString();
          return postList;
        } else {
          getIt<SharedPreferencesModel>().setUserPostsApiCallStatus(true);
          emit(
            state.copyWith(
              status: UserPostsStatus.failure,
            ),
          );
          throw Exception("Failed to load post");
        }
      } on SocketException {
        emit(
          state.copyWith(
              status: UserPostsStatus.socketStatus,
              str: "No Internet Connection"),
        );
        // Handle socket exception
        return Future.error("No Internet Connection");
      }
    }
  }

  List<UserPostTableData>? getAllPostsById(int id) {
    try {
      log("calling try");
      // emit(RegisteredPostLoadingState());

      getIt<AppDatabase>()
          .userPostTableDao
          .getAllPostsByUserId(id)
          .listen((id) async {
        log("$userPostTableData", name: "userPostTableData");

        userPostTableData.clear();
        for (var element in id) {
          userPostTableData.add(UserPostTableData(
              userId: element.userId,
              postId: element.postId,
              postTitle: element.postTitle,
              postBody: element.postBody,));
          //log("$element",name:"element");
        }
        emit(state.copyWith(
          status: UserPostsStatus.success,
          listUserPostTableData: userPostTableData,
        ));
        // emit(RegisteredPostLoadedState(postDataList));
        // log("list length=${postDataList.length}");
      });
    } catch (e) {
      emit(state.copyWith(
        status: UserPostsStatus.failure,
        str: (e.toString()),
      ));
    }
  }
}







































//api calling user posts
// Future<List<PostModel>> fetchPostsById(int id) async {
//   emit(state.copyWith(status: UserPostsStatus.loading));
//   try {
//     final response = await http
//         .get(Uri.parse(
//             'https://jsonplaceholder.typicode.com/users/' "$id" '/posts'))
//         .timeout(const Duration(seconds: timeOutDuration));
//     if (response.statusCode == 200) {
//       var body = jsonDecode(response.body);
//       List<PostModel> postModel = (json.decode(response.body) as List)
//           .map((data) => PostModel.fromJson(data))
//           .toList();
//       log(postModel.length.toString());
//
//       postList.clear();
//       for (var element in body) {
//         PostModel postModel = PostModel(
//             userId: element["userId"],
//             id: element["id"],
//             title: element["title"],
//             body: element["body"]);
//         postList.add(postModel);
//       }
//
//       log(postModel.length.toString(), name: "postModel");
//
//       // onSearchById(
//       //     getIt<SharedPreferencesModel>().getLoginId("userId").toInt())
//       //     .then((value) => {
//       //   if (value.isNotEmpty)
//       //     {
//       //       emit(
//       //         state.copyWith(
//       //             status: UserStatus.success, listPostModel: value),
//       //       )
//       //     }
//       //   else
//       //     {
//       //       emit(
//       //         state.copyWith(status: UserStatus.failure),
//       //       )
//       //     }
//       // });
//
//       emit(
//         state.copyWith(
//             status: UserPostsStatus.success, listPostModel: postList),
//       );
//
//       //user = body.toString();
//       return postList;
//     } else {
//       emit(
//         state.copyWith(
//           status: UserPostsStatus.failure,
//         ),
//       );
//       throw Exception("Failed to load post");
//     }
//   } on SocketException {
//     emit(
//       state.copyWith(
//         status: UserPostsStatus.socketStatus,
//       ),
//     );
//     // Handle socket exception
//     return Future.error("No Internet Connection");
//   }
// }
