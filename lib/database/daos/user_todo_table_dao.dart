import 'dart:developer';

import 'package:api_first_app/model/todos_model.dart';
import 'package:drift/drift.dart';
import '../db/app_database.dart';
import '../tables/user_post_table.dart';
import '../tables/user_todo_table.dart';
import 'package:drift/drift.dart' as drift;

part 'user_todo_table_dao.g.dart';

@DriftAccessor(tables: [UserPostTable, UserTodoTable])
class UserTodoTableDao extends DatabaseAccessor<AppDatabase>
    with _$UserTodoTableDaoMixin {
  final AppDatabase db;

  UserTodoTableDao(this.db) : super(db);

  Future<int> addUserTodo(UserTodoTableCompanion entry) {
    return into(userTodoTable).insert(entry);
  }
  //Future<int> insertTodoEntry(UserTodoTableCompanion entry) => into(userTodoTable).insert(entry);
  Future<List<UserTodoTableData>> getAllTodos() => select(userTodoTable).get();
  Stream<List<UserTodoTableData>> getAllTodosByUserId(userId) {
    log(userId, name: "userId");
    return (select(userTodoTable)..where((tbl) => tbl.userId.equals(userId)))
        .watch();
  }
  Future<void> insertTodos(List<TodosModel> todos) async {
    log("$todos", name: "todosss");
    // await batch((batch) {
    //   batch.insertAll( userTodoTable,todos.map((todo) => UserTodoTableCompanion.insert(
    //     userId: Value(todo.userId),
    //     todoId: Value(todo.id!),
    //     todoTitle: Value(todo.title),
    //     isCompleted: Value(todo.completed),
    //   )).toList());
    // });

    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        userTodoTable,
        todos.map((todo) => UserTodoTableCompanion(
          userId: drift.Value(todo.userId),
          todoId: drift.Value(todo.id!),
          todoTitle: drift.Value(todo.title),
          isCompleted: drift.Value(todo.completed),
        )).toList(),
      );
    });
  }
  //Get a single userTodo
  Future<UserTodoTableData> getUserTodo(int id) async {
    return await (select(userTodoTable)..where((tbl) => tbl.userId.equals(id)))
        .getSingle();
  }

  Stream<List<UserTodoTableData>> getAllUserTodosByUserId(userId) {
    log(userId, name: "userId");
    return (select(userTodoTable)..where((tbl) => tbl.userId.equals(userId)))
        .watch();
  }

}
