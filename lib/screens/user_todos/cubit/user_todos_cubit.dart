import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '../../../database/db/app_database.dart';
import '../../../main.dart';
import '../../../model/shared_preferences_model.dart';
import '../../../model/todos_model.dart';
part 'user_todos_state.dart';

class UserTodosCubit extends Cubit<UserTodosState> {
  UserTodosCubit() : super(const UserTodosState());

  late List<UserTodoTableData> userTodoTableData = [];

  late List<TodosModel> todosList = [];

  late String? user;
  static const int timeOutDuration = 5;

  void handleBackPress() {
    emit(
      state.copyWith(
        status: UserTodosStatus.initial,
      ),
    );
  }

//fetching specific user todos by user id
  Future<Object?> fetchTodosById(int id) async {
    emit(state.copyWith(status: UserTodosStatus.loading));
    var checkApiCall = getIt<SharedPreferencesModel>().getTodoApiCallStatus();
    log('$checkApiCall', name: "checkApiCallTodo");
    if (checkApiCall) {
      List<UserTodoTableData>? list = getAllTodosById(id);
      return list;
    } else {

      try {
        final response = await http
            .get(Uri.parse(
            'https://jsonplaceholder.typicode.com/users/' "$id" '/todos'))
            .timeout(const Duration(seconds: timeOutDuration));
        if (response.statusCode == 200) {

          getIt<SharedPreferencesModel>().setTodoApiCallStatus(true);
          log('${response.statusCode}', name: "statusCode");
          log('$checkApiCall', name: "checkApiCall");
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
                completed: element["completed"],);
            todosList.add(todosModel);
          }
          await getIt<AppDatabase>().userTodoTableDao.insertTodos(todosList);
          int id = getIt<SharedPreferencesModel>().getLoginId("userId");

          List<UserTodoTableData>? dbList = getAllTodosById(id);

          log('${todosList.length}', name: "todosList");

          emit(
            state.copyWith(
                status: UserTodosStatus.success, listUserTodoTableData: dbList),
          );

          //user = body.toString();
          return todosList;
        } else {
         // getIt<SharedPreferencesModel>().setTodoApiCallStatus(true);
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


  List<UserTodoTableData>? getAllTodosById(int id) {
    try {
      log("calling try");
      // emit(RegisteredPostLoadingState());

      getIt<AppDatabase>()
          .userTodoTableDao
          .getAllTodosByUserId(id)
          .listen((id) async {
        log("${userTodoTableData.length}", name: "userTodoTableData");

        userTodoTableData.clear();
        for (var element in id) {
          userTodoTableData.add(UserTodoTableData(
              todoId: element.todoId,
              userId: element.userId,
              todoTitle: element.todoTitle,
              isCompleted: element.isCompleted,));
          //log("$element",name:"element");
        }
        emit(state.copyWith(
          status: UserTodosStatus.success,
          listUserTodoTableData: userTodoTableData,
        ));
        // emit(RegisteredPostLoadedState(postDataList));
        // log("list length=${postDataList.length}");
      });
    } catch (e) {
      emit(state.copyWith(
        status: UserTodosStatus.failure,
        str: (e.toString()),
      ));
    }
  }

}






















// List<UserTodoTableData>? getAllTodos(int id) {
//   log("calling getTodos");
//
//   try {
//     log("calling try");
//     emit(
//       state.copyWith(
//         status: UserTodosStatus.loading,
//       ),
//     );
//
//      getIt<AppDatabase>()
//         .userTodoTableDao
//         .getAllUserTodosByUserId(id)
//         .listen((id) async {
//       //log("event $value");
//
//       todosList.clear();
//       userTodoTableData.clear();
//       for (var element in id) {
//         log("registered list=$element");
//         userTodoTableData.add(UserTodoTableData(
//             todoId: element.todoId,
//             userId: element.userId,
//             todoTitle: element.todoTitle,
//             isCompleted: element.isCompleted));
//
//         //log("LoadedState");
//       }
//
//       emit(
//         state.copyWith(
//             status: UserTodosStatus.success,
//             listUserTodoTableData: userTodoTableData),
//       );
//       log("list length=${userTodoTableData.length}");
//     });
//      return userTodoTableData;
//   } catch (e) {
//     log(" error $e");
//     // emit(state.copyWith(
//     //   status: UserTodosStatus.failure,
//     //   str: (e.toString()),
//     // ));
//     return null;
//   }
// }



// Future<List<TodosModel>> fetchTodosById(int id) async {
//   emit(state.copyWith(status: UserTodosStatus.loading));
//   try {
//     final response = await http
//         .get(Uri.parse(
//             'https://jsonplaceholder.typicode.com/users/' "$id" '/todos'))
//         .timeout(const Duration(seconds: timeOutDuration));
//     if (response.statusCode == 200) {
//       var body = jsonDecode(response.body);
//       List<TodosModel> todosModel = (json.decode(response.body) as List)
//           .map((data) => TodosModel.fromJson(data))
//           .toList();
//       log(todosModel.length.toString(), name: "todosModel");
//
//       await getIt<UserTodoTableDao>().insertTodos(todosModel);
//
//       log(todosModel.length.toString());
//       log(todosModel.length.toString(), name: "todosModel");
//
//       todosList.clear();
//       for (var element in body) {
//         TodosModel todosModel = TodosModel(
//             userId: element["userId"],
//             id: element["id"],
//             title: element["title"],
//             completed: element["completed"]);
//         todosList.add(todosModel);
//       }
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
//             status: UserTodosStatus.success, listTodosModel: todosList),
//       );
//
//       //user = body.toString();
//       log(todosList.length.toString(), name: "todosList");
//       return todosList;
//     } else {
//       emit(
//         state.copyWith(
//           status: UserTodosStatus.failure,
//         ),
//       );
//       throw Exception("Failed to load post");
//     }
//   } on SocketException {
//     emit(
//       state.copyWith(
//         status: UserTodosStatus.socketStatus,
//       ),
//     );
//     // Handle socket exception
//     return Future.error("No Internet Connection");
//   }
// }

// Future<List<UserTodoTableData>?> getTodos(int id) async {
//   emit(
//     state.copyWith(
//       status: UserTodosStatus.loading,
//     ),
//   );
//   if(getIt<SharedPreferencesModel>().getTodoApiCallStatus() == false){
//     getIt<SharedPreferencesModel>().setTodoApiCallStatus(true);
//     log('false', name: "falseeeee");
//     try {
//       log('if', name: "if");
//       log('$userTodoTableData', name: "userTodoTableData");
//       final response = await http.get(Uri.parse(
//           'https://jsonplaceholder.typicode.com/users/' "$id" '/todos'));
//       final List<dynamic> jsonResponse = json.decode(response.body);
//
//       final todos = jsonResponse.map((e) => TodosModel.fromJson(e)).toList();
//       for (var todo in todos) {
//         final entry = UserTodoTableCompanion(
//           userId: drift.Value(todo.userId!),
//           todoId: drift.Value(todo.id!),
//           todoTitle: drift.Value(todo.title!),
//           isCompleted: drift.Value(todo.completed!),
//         );
//         log('$entry', name: "entry");
//
//         await getIt<AppDatabase>().userTodoTableDao.insertTodoEntry(entry);
//       }
//
//       // getIt<UserTodoTableDao>().getAllTodosByUserId(id).listen((userId) {
//       //   userTodoTableData.clear();
//       //   for (var element in userId) {
//       //     log("registered list=$element");
//       //     userTodoTableData.add(UserTodoTableData(
//       //       userId: element.userId,
//       //       todoId: element.todoId,
//       //       todoTitle: element.todoTitle,
//       //       isCompleted: element.isCompleted,
//       //     ));
//       //
//       //     //log("LoadedState");
//       //   }
//       // });
//       log(userTodoTableData.length.toString(), name: "userTodoTableData");
//       emit(
//         state.copyWith(
//             status: UserTodosStatus.success,
//             listUserTodoTableData: userTodoTableData),
//       );
//       return userTodoTableData;
//     } catch (e) {
//       log(e.toString(), name: "eee");
//
//       emit(state.copyWith(status: UserTodosStatus.failure, str: e.toString()));
//       return null;
//
//     }
//   }else{
//     getIt<SharedPreferencesModel>().setTodoApiCallStatus(true);
//     log('true', name: "trueeee");
//
//     getIt<UserTodoTableDao>().getAllTodosByUserId(id).listen((userId) {
//       userTodoTableData.clear();
//       for (var element in userId) {
//         log("registered list=$element");
//         userTodoTableData.add(UserTodoTableData(
//           userId: element.userId,
//           todoId: element.todoId,
//           todoTitle: element.todoTitle,
//           isCompleted: element.isCompleted,
//         ));
//
//         //log("LoadedState");
//       }
//     });
//     log(userTodoTableData.length.toString(), name: "userTodoTableData");
//     emit(
//       state.copyWith(
//           status: UserTodosStatus.success,
//           listUserTodoTableData: userTodoTableData),
//     );
//   }
//   return null;
// }
