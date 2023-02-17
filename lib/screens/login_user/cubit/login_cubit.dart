import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';
import '../../../model/shared_preferences_model.dart';
import '../../../model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../user_posts/user_posts_screen.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  var userModel = UserModel();
  late List<UserModel> userList = [];
  late List<UserModel> resultList = [];
  late String? user;

  static const int timeOutDuration = 5;

  Future<List<UserModel>> fetchUsers(BuildContext context, String userEmail) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'))
          .timeout(const Duration(seconds: timeOutDuration));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<UserModel> userModel = (json.decode(response.body) as List)
            .map((data) => UserModel.fromJson(data))
            .toList();
        log("$userModel.length.toString()", name: "userModel");

        userModel[0];
        for (var element in body) {
          UserModel userModel = UserModel(
            id: element["id"],
            name: element["name"],
            username: element["username"],
            email: element["email"],
            address: element["address"],
            phone: element["phone"],
            website: element["website"],
            company: element["company"],
          );
          userList.add(userModel);

          //log("${element.body[0]}");
          // log("registered list=${element}");
          //postList.add(PostModel());
        }
        emit(
          state.copyWith(status: LoginStatus.success, userModel: userModel),
        );
        user = body.toString();
         login( context,  userEmail);

        return userList;
      } else {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
          ),
        );
        throw Exception("Failed to load post");
      }
    } on SocketException {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
        ),
      );
      // Handle socket exception
      return Future.error("No Internet Connection");
    } on TimeoutException {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
        ),
      );
      // Handle timeout exception
      return Future.error("Request Timeout Exception");
    } on http.ClientException {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
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

  // , String userPassword
  void login(BuildContext context, String userEmail) {
    emit(state.copyWith(status: LoginStatus.loading));

    onSearchEmail(context, userEmail).then((value) async {
      log("value $value");

      try {
        // Make API request
        final response = await http
            .get(Uri.parse('https://jsonplaceholder.typicode.com/'))
            .timeout(const Duration(seconds: timeOutDuration));

        if (response.statusCode == 200) {
          // Update the authentication state
          emit(state.copyWith(status: LoginStatus.success, userModel: value));
          log("$state", name: "currentState");
        } else {
          // Handle authentication error
          emit(state.copyWith(
              status: LoginStatus.loading, str: "Network error"));
        }
      } catch (e) {
        // Handle network or server errors
        emit(state.copyWith(status: LoginStatus.loading, str: "Network error"));
      }

      if (userModel.email == userEmail) {
        emit(state.copyWith(status: LoginStatus.success));
        getIt<SharedPreferencesModel>().setLoginStatus(true);
        // prefs.setBool("isLoggedIn", true);
        getIt<SharedPreferencesModel>().setLoginEmail(userEmail);
        // prefs.setString("userEmail", userEmail);
        log(userEmail, name: "userEmail");
        // BlocProvider.of<RegisteredPostCubit>(context).getAllPost(userEmail);

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const UserPostsScreen();
        }));
      } else {
        emit(state.copyWith(status: LoginStatus.failure));
      }
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: LoginStatus.failure));
    });
  }

  // Future<UserModel> checkUser(
  //   context,
  //   String userEmail,
  //   String userPassword,
  // ) async {
  //   // getIt<AppDatabase>()
  //   //     .usersTableDao
  //   //     .loginByEmailPassword(userEmail, userPassword);
  //   return await getIt<AppDatabase>()
  //       .usersTableDao
  //       .loginByEmailPassword(userEmail, userPassword);
  // }

  Future<List<UserModel>> onSearchEmail(
    context,
    String userEmail,
  ) async {
    //log(value, name: "value");
    List<UserModel> filteredUser = userList
        .where((item) => item
            .toJson()
            .toString()
            .toLowerCase()
            .contains(userEmail.toLowerCase()))
        .toList();

    for (var element in filteredUser) {
      log("${element.email}", name: "email");

      UserModel userModel = UserModel(
        id: element.id,
        name: element.name,
        email: element.email,
        address: element.address,
        phone: element.phone,
        website: element.website,
        company: element.company,
      );
      resultList.add(userModel);
      log("$userModel.", name: "userModel");
      log("$resultList.", name: "resultList");
    }
    emit(state.copyWith(status: LoginStatus.loading, userModel: filteredUser));
    log("$state", name: "state");
    log("$filteredUser", name: "filteredUser");
    log("$userModel", name: "userModel");

    return resultList;
  }
}
