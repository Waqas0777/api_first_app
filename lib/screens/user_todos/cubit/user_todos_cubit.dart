import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../model/post_model.dart';
import '../../../model/todos_model.dart';

part 'user_todos_state.dart';

class UserTodosCubit extends Cubit<UserTodosState> {
  UserTodosCubit() : super(const UserTodosState());
  var todosModel = TodosModel();

  late List<TodosModel> todosList = [];
  late List<TodosModel> todosResultList = [];
  late String? user;
  static const int timeOutDuration = 5;

  void handleBackPress() {
    // Emit the initial state
    emit(
      state.copyWith(
        status: UserTodosStatus.initial,
      ),
    );
  }

  //fetching specific user todos by user id
  Future<List<TodosModel>> fetchTodosById(int id) async {
    emit(state.copyWith(status: UserTodosStatus.loading));
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users/'"$id"'/todos'))
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
          state.copyWith(status: UserTodosStatus.success, listTodosModel: todosList),
        );

        //user = body.toString();
        return todosList;
      } else {
        emit(
          state.copyWith(
            status: UserTodosStatus.failure,
          ),
        );
        throw Exception("Failed to load post");
      }
    } on SocketException {
      emit(
        state.copyWith(
          status: UserTodosStatus.socketStatus,
        ),
      );
      // Handle socket exception
      return Future.error("No Internet Connection");
    }
  }

}
