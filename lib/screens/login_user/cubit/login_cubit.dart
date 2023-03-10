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
import '../../posts/post_screen.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());
  late UserModel? userModel;
  late List<UserModel> userList = [];
  late List<UserModel> resultList = [];

  //late String? user;

  static const int timeOutDuration = 5;

  Future<List<UserModel>> fetchUsers(
      BuildContext context, String userEmail) async {
    emit(state.copyWith(status: LoginStatus.loading));
    log(userEmail, name: "userEmail");
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'))
          .timeout(const Duration(seconds: timeOutDuration));
      if (response.statusCode == 200) {

        var body = jsonDecode(response.body);
        //log("$body", name: "body");

        List<UserModel> listUserModel = (json.decode(response.body) as List)
            .map((data) => UserModel.fromJson(data))
            .toList();
       // log("$listUserModel", name: "userModel");
        for (var element in listUserModel) {
          userModel = UserModel(
              name: element.name,
              id: element.id,
              username: element.username,
              address: element.address,
              phone: element.phone,
              website: element.website,
              company: element.company,
              email: element.email);

          userList.add(userModel!);
        }

       // log(listUserModel.length.toString(), name: "userModel");

        checkUserExists(context,userEmail, listUserModel, userModel!)
            .then((value) async {
          if (value) {
            emit(
              state.copyWith(
                status: LoginStatus.success,
              ),
            );

            // getIt<SharedPreferencesModel>()
            //     .setLoginStatus(true); // prefs.setBool("isLoggedIn", true);
            // getIt<SharedPreferencesModel>().setLoginEmail(userEmail);
            // BlocProvider.of<UserCommentCubit>(context).fetchComments();

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                 // showInSnackBar(context,"Success", Colors.green);
              return const PostScreen();
            }));
          } else {
            log("$value",name: "state");
            emit(
              state.copyWith(
                status: LoginStatus.failure,
              ),
            );

            showInSnackBar(context,"Failed", Colors.red);


          }
        }).onError((error, stackTrace) {
          emit(
            state.copyWith(
              status: LoginStatus.failure,
            ),
          );

          showInSnackBar(context,"Failed", Colors.red);
        });
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
          status: LoginStatus.internetIssue,
        ),
      );
      showInSnackBar(context,"Internet Issue", Colors.blueGrey);
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
      log("$e", name: "catch error");
      return Future.error("Something Went Wrong");
    }
  }

  Future<bool> checkUserExists(BuildContext context,String userEmail, List<UserModel> listUserModel,
      UserModel userModel) async {
    for (userModel in listUserModel) {
      userModel =
          listUserModel.firstWhere((userModel) => userModel.email == userEmail);
      log("${userModel.website}", name: "website");
      log("$userModel", name: "userModel");

      getIt<SharedPreferencesModel>()
          .setLoginStatus(true); // prefs.setBool("isLoggedIn", true);
      getIt<SharedPreferencesModel>().setLoginEmail(userEmail);
      getIt<SharedPreferencesModel>().setLoginId(userModel.id!.toInt());

      String userModelData = jsonEncode(userModel);
      getIt<SharedPreferencesModel>().setUser(userModelData);

      log("${userModel.email}", name: "email");
      log(userModelData, name: "userModelData");

      return true;
    }
    //showInSnackBarError(context,"Failed", Colors.red);

    return false;
  }

  void showInSnackBar(BuildContext context,String value, Color color) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return const PostScreen();
    }));
    var snackBar = SnackBar(content: Text(value), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
