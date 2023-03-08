import 'dart:developer';

import 'package:drift/drift.dart';
import '../../model/post_model.dart';
import '../db/app_database.dart';
import '../tables/user_post_table.dart';
import '../tables/user_todo_table.dart';
import 'package:drift/drift.dart' as drift;

part 'user_post_table_dao.g.dart';

@DriftAccessor(tables: [UserPostTable, UserTodoTable])
class UserPostTableDao extends DatabaseAccessor<AppDatabase>
    with _$UserPostTableDaoMixin {
  final AppDatabase db;

  UserPostTableDao(this.db) : super(db);

  Future<int> addUserPost(UserPostTableCompanion entry) {
    return into(userPostTable).insert(entry);
  }
  Stream<List<UserPostTableData>> getAllPostsByUserId(int userId) {
    log("$getAllPostsByUserId", name: "getAllPostsByUserId called");
    return (select(userPostTable)..where((tbl) => tbl.userId.equals(userId)))
        .watch();
  }


  Future<void> insertPosts(List<PostModel> posts) async {
    log("$posts", name: "todosss");

    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        userPostTable,
        posts.map((post) => UserPostTableCompanion(
          userId: drift.Value(post.userId),
          postId: drift.Value(post.id!),
          postTitle: drift.Value(post.title),
          postBody: drift.Value(post.body),
        )).toList(),
      );
    });
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
