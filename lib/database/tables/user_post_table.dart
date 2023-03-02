
import 'package:drift/drift.dart';

class UserPostTable extends Table {
  IntColumn get userId => integer().nullable()();
  IntColumn get postId => integer().autoIncrement()();

  TextColumn get postTitle => text().nullable()();

  TextColumn get postBody => text().nullable()();
// BoolColumn get todoCompleted =>  boolean().withDefault(const Constant(false))();


}