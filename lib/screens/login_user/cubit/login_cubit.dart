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
import '../../user_comments/cubit/user_comment_cubit.dart';
import '../../user_comments/user_comments_screen.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  var userModel = UserModel();
  late List<UserModel> userList = [];
  late List<UserModel> resultList = [];
  late String? user;

  static const int timeOutDuration = 10;

  Future<List<UserModel>> fetchUsers(
      BuildContext context, String userEmail) async {
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
        log("$userModel", name: "userModel");
        log("onSearch", name: "search call");
        checkUserExists(userEmail, userModel).then((value) async {
          log("$value", name: "value");

          if (value) {
            emit(
              state.copyWith(
                status: LoginStatus.success,
              ),
            );
            getIt<SharedPreferencesModel>()
                .setLoginStatus(true); // prefs.setBool("isLoggedIn", true);
            getIt<SharedPreferencesModel>().setLoginEmail(userEmail);
           // BlocProvider.of<UserCommentCubit>(context).fetchComments();

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return const UserCommentsScreen();
            }));

          } else {
            emit(
              state.copyWith(
                status: LoginStatus.failure,
              ),
            );
          }
        }).onError((error, stackTrace) {
          emit(
            state.copyWith(
              status: LoginStatus.failure,
            ),
          );
        });
        // if(userExist){
        //   emit(state.copyWith(status: LoginStatus.success,));
        //    log("state",name: "state");
        //
        // }else{
        //   emit(state.copyWith(status: LoginStatus.success,));
        //    log("state",name: "state");
        //
        // }
        // for (var element in body) {
        //   UserModel userModel = UserModel(
        //     id: element["id"],
        //     name: element["name"],
        //     username: element["username"],
        //     email: element["email"],
        //     address: element["address"],
        //     phone: element["phone"],
        //     website: element["website"],
        //     company: element["company"],
        //   );
        //   userList.add(userModel);
        // }
        // emit(
        //   state.copyWith(status: LoginStatus.success, userModel: userModel),
        // );
        user = body.toString();
        // log("onSearch",name: "search call");
        // onSearch(userEmail,userModel);

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

  //search on specific field
  // Future<List<UserModel>> onSearch(String searchQuery,List<UserModel> userModel) async {
  //   log(searchQuery, name: "searchQuery");
  //   List<UserModel> filteredItems = userModel
  //       .where((item) =>
  //           item.email!.toLowerCase().contains(searchQuery.toLowerCase()))
  //       .toList();
  //   log("$filteredItems", name: "filteredItems");
  //
  //   // for (var element in filteredItems) {
  //   //   log("${element.email}", name: "element");
  //   //   log("$filteredItems $searchQuery", name: "filteredItems");
  //   //
  //   //   UserModel postModel = UserModel(
  //   //       id: element.id,
  //   //       name: element.name,
  //   //       username: element.username,
  //   //       email: element.email,
  //   //       address: element.address,
  //   //       phone: element.phone,
  //   //       website: element.website,
  //   //       company: element.company);
  //   //   resultList.add(postModel);
  //   // }
  //   emit(state.copyWith(status: LoginStatus.success, userModel: filteredItems));
  //   log("$state", name: "state");
  //   return resultList;
  // }

  Future<bool> checkUserExists(String email, List<UserModel> users) async {
    bool userExists = users.any((user) => user.email == email);
    log("$userExists", name: "userExists");

    emit(state.copyWith(status: LoginStatus.success));

    return userExists;
  }

// Future<List<UserModel>> onSearchEmail(
//   context,
//   String userEmail,
// ) async {
//   //log(value, name: "value");
//   List<UserModel> filteredUser = userList
//       .where((item) => item
//           .toJson()
//           .toString()
//           .toLowerCase()
//           .contains(userEmail.toLowerCase()))
//       .toList();
//
//   for (var element in filteredUser) {
//     log("${element.email}", name: "email");
//
//     UserModel userModel = UserModel(
//       id: element.id,
//       name: element.name,
//       email: element.email,
//       address: element.address,
//       phone: element.phone,
//       website: element.website,
//       company: element.company,
//     );
//     resultList.add(userModel);
//     log("$userModel.", name: "userModel");
//     log("$resultList.", name: "resultList");
//   }
//   emit(state.copyWith(status: LoginStatus.loading, userModel: filteredUser));
//   log("$state", name: "state");
//   log("$filteredUser", name: "filteredUser");
//   log("$userModel", name: "userModel");
//
//   return resultList;
// }
}
