import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:api_first_app/model/post_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(const PostState());

  late List<PostModel> postList = [];
  late String? user;
  static const int timeOutDuration = 3;

  //https://jsonplaceholder.typicode.com/posts

  Future<List<PostModel>> fetchUsers() async {
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
        log(postModel.length);

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
}
