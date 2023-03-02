import 'dart:developer';

import 'package:drift/drift.dart';
import '../db/app_database.dart';
import '../tables/user_post_table.dart';
import '../tables/user_todo_table.dart';

part 'user_post_table_dao.g.dart';

@DriftAccessor(tables: [UserPostTable, UserTodoTable])
class UserPostTableDao extends DatabaseAccessor<AppDatabase>
    with _$UserPostTableDaoMixin {
  final AppDatabase db;

  UserPostTableDao(this.db) : super(db);

  Future<int> addUserPost(UserPostTableCompanion entry) {
    return into(userPostTable).insert(entry);
  }




  //Get a single post
  Future<UserPostTableData> getUserPost(int id) async {
    return await (select(userPostTable)..where((tbl) => tbl.userId.equals(id)))
        .getSingle();
  }

  Stream<List<UserPostTableData>> getAllUserPostByUserId(userId) {
    log(userId, name: "userId");
    return (select(userPostTable)..where((tbl) => tbl.userId.equals(userId)))
        .watch();
  }

}
