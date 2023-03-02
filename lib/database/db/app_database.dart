import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as path;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import '../daos/user_post_table_dao.dart';
import '../daos/user_todo_table_dao.dart';
import '../tables/user_post_table.dart';
import '../tables/user_todo_table.dart';

part 'app_database.g.dart';

//specifying location to database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, "appDb.sqlite"));
    return NativeDatabase(file);
  });
}

@DriftDatabase(
    tables: [UserPostTable, UserTodoTable],
    daos: [UserPostTableDao, UserTodoTableDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
