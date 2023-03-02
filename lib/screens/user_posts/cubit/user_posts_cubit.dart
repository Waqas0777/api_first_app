import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../model/post_model.dart';
import 'package:http/http.dart' as http;

part 'user_posts_state.dart';

class UserPostsCubit extends Cubit<UserPostsState> {
  UserPostsCubit() : super(const UserPostsState());
  var postModel = PostModel();
  late List<PostModel> postList = [];
  late List<PostModel> resultList = [];
  late String? user;
  static const int timeOutDuration = 5;

  // Define a method to handle the back press
  void handleBackPress() {
    // Emit the initial state
    emit(
      state.copyWith(
        status: UserPostsStatus.initial,
      ),
    );
  }

  Future<List<PostModel>> fetchPostsById(int id) async {
    emit(state.copyWith(status: UserPostsStatus.loading));
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
          state.copyWith(
              status: UserPostsStatus.success, listPostModel: postList),
        );

        //user = body.toString();
        return postList;
      } else {
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
        ),
      );
      // Handle socket exception
      return Future.error("No Internet Connection");
    }
  }
}
