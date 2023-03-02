
import 'package:drift/drift.dart';
import 'package:mixins/mixins.dart';

class UserTodoTable extends Table {
  IntColumn get userId => integer().isNotNull()();
  IntColumn get todoId => integer().autoIncrement()();

  TextColumn get todoTitle => text().isNotNull()();

  BoolColumn get isCompleted => boolean().isNotNull()();
  // BoolColumn get todoCompleted =>  boolean().withDefault(const Constant(false))();


}