// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserPostTableTable extends UserPostTable
    with TableInfo<$UserPostTableTable, UserPostTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPostTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<int> postId = GeneratedColumn<int>(
      'post_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _postTitleMeta =
      const VerificationMeta('postTitle');
  @override
  late final GeneratedColumn<String> postTitle = GeneratedColumn<String>(
      'post_title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _postBodyMeta =
      const VerificationMeta('postBody');
  @override
  late final GeneratedColumn<String> postBody = GeneratedColumn<String>(
      'post_body', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [userId, postId, postTitle, postBody];
  @override
  String get aliasedName => _alias ?? 'user_post_table';
  @override
  String get actualTableName => 'user_post_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserPostTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    }
    if (data.containsKey('post_title')) {
      context.handle(_postTitleMeta,
          postTitle.isAcceptableOrUnknown(data['post_title']!, _postTitleMeta));
    }
    if (data.containsKey('post_body')) {
      context.handle(_postBodyMeta,
          postBody.isAcceptableOrUnknown(data['post_body']!, _postBodyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {postId};
  @override
  UserPostTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPostTableData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      postId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}post_id'])!,
      postTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_title']),
      postBody: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_body']),
    );
  }

  @override
  $UserPostTableTable createAlias(String alias) {
    return $UserPostTableTable(attachedDatabase, alias);
  }
}

class UserPostTableData extends DataClass
    implements Insertable<UserPostTableData> {
  final int? userId;
  final int postId;
  final String? postTitle;
  final String? postBody;
  const UserPostTableData(
      {this.userId, required this.postId, this.postTitle, this.postBody});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['post_id'] = Variable<int>(postId);
    if (!nullToAbsent || postTitle != null) {
      map['post_title'] = Variable<String>(postTitle);
    }
    if (!nullToAbsent || postBody != null) {
      map['post_body'] = Variable<String>(postBody);
    }
    return map;
  }

  UserPostTableCompanion toCompanion(bool nullToAbsent) {
    return UserPostTableCompanion(
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      postId: Value(postId),
      postTitle: postTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(postTitle),
      postBody: postBody == null && nullToAbsent
          ? const Value.absent()
          : Value(postBody),
    );
  }

  factory UserPostTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPostTableData(
      userId: serializer.fromJson<int?>(json['userId']),
      postId: serializer.fromJson<int>(json['postId']),
      postTitle: serializer.fromJson<String?>(json['postTitle']),
      postBody: serializer.fromJson<String?>(json['postBody']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int?>(userId),
      'postId': serializer.toJson<int>(postId),
      'postTitle': serializer.toJson<String?>(postTitle),
      'postBody': serializer.toJson<String?>(postBody),
    };
  }

  UserPostTableData copyWith(
          {Value<int?> userId = const Value.absent(),
          int? postId,
          Value<String?> postTitle = const Value.absent(),
          Value<String?> postBody = const Value.absent()}) =>
      UserPostTableData(
        userId: userId.present ? userId.value : this.userId,
        postId: postId ?? this.postId,
        postTitle: postTitle.present ? postTitle.value : this.postTitle,
        postBody: postBody.present ? postBody.value : this.postBody,
      );
  @override
  String toString() {
    return (StringBuffer('UserPostTableData(')
          ..write('userId: $userId, ')
          ..write('postId: $postId, ')
          ..write('postTitle: $postTitle, ')
          ..write('postBody: $postBody')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, postId, postTitle, postBody);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPostTableData &&
          other.userId == this.userId &&
          other.postId == this.postId &&
          other.postTitle == this.postTitle &&
          other.postBody == this.postBody);
}

class UserPostTableCompanion extends UpdateCompanion<UserPostTableData> {
  final Value<int?> userId;
  final Value<int> postId;
  final Value<String?> postTitle;
  final Value<String?> postBody;
  const UserPostTableCompanion({
    this.userId = const Value.absent(),
    this.postId = const Value.absent(),
    this.postTitle = const Value.absent(),
    this.postBody = const Value.absent(),
  });
  UserPostTableCompanion.insert({
    this.userId = const Value.absent(),
    this.postId = const Value.absent(),
    this.postTitle = const Value.absent(),
    this.postBody = const Value.absent(),
  });
  static Insertable<UserPostTableData> custom({
    Expression<int>? userId,
    Expression<int>? postId,
    Expression<String>? postTitle,
    Expression<String>? postBody,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (postId != null) 'post_id': postId,
      if (postTitle != null) 'post_title': postTitle,
      if (postBody != null) 'post_body': postBody,
    });
  }

  UserPostTableCompanion copyWith(
      {Value<int?>? userId,
      Value<int>? postId,
      Value<String?>? postTitle,
      Value<String?>? postBody}) {
    return UserPostTableCompanion(
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      postTitle: postTitle ?? this.postTitle,
      postBody: postBody ?? this.postBody,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<int>(postId.value);
    }
    if (postTitle.present) {
      map['post_title'] = Variable<String>(postTitle.value);
    }
    if (postBody.present) {
      map['post_body'] = Variable<String>(postBody.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPostTableCompanion(')
          ..write('userId: $userId, ')
          ..write('postId: $postId, ')
          ..write('postTitle: $postTitle, ')
          ..write('postBody: $postBody')
          ..write(')'))
        .toString();
  }
}

class $UserTodoTableTable extends UserTodoTable
    with TableInfo<$UserTodoTableTable, UserTodoTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTodoTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _todoIdMeta = const VerificationMeta('todoId');
  @override
  late final GeneratedColumn<int> todoId = GeneratedColumn<int>(
      'todo_id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _todoTitleMeta =
      const VerificationMeta('todoTitle');
  @override
  late final GeneratedColumn<String> todoTitle = GeneratedColumn<String>(
      'todo_title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted =
      GeneratedColumn<bool>('is_completed', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_completed" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns =>
      [userId, todoId, todoTitle, isCompleted];
  @override
  String get aliasedName => _alias ?? 'user_todo_table';
  @override
  String get actualTableName => 'user_todo_table';
  @override
  VerificationContext validateIntegrity(Insertable<UserTodoTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('todo_id')) {
      context.handle(_todoIdMeta,
          todoId.isAcceptableOrUnknown(data['todo_id']!, _todoIdMeta));
    }
    if (data.containsKey('todo_title')) {
      context.handle(_todoTitleMeta,
          todoTitle.isAcceptableOrUnknown(data['todo_title']!, _todoTitleMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {todoId};
  @override
  UserTodoTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTodoTableData(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      todoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}todo_id'])!,
      todoTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}todo_title']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed']),
    );
  }

  @override
  $UserTodoTableTable createAlias(String alias) {
    return $UserTodoTableTable(attachedDatabase, alias);
  }
}

class UserTodoTableData extends DataClass
    implements Insertable<UserTodoTableData> {
  final int? userId;
  final int todoId;
  final String? todoTitle;
  final bool? isCompleted;
  const UserTodoTableData(
      {this.userId, required this.todoId, this.todoTitle, this.isCompleted});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['todo_id'] = Variable<int>(todoId);
    if (!nullToAbsent || todoTitle != null) {
      map['todo_title'] = Variable<String>(todoTitle);
    }
    if (!nullToAbsent || isCompleted != null) {
      map['is_completed'] = Variable<bool>(isCompleted);
    }
    return map;
  }

  UserTodoTableCompanion toCompanion(bool nullToAbsent) {
    return UserTodoTableCompanion(
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      todoId: Value(todoId),
      todoTitle: todoTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(todoTitle),
      isCompleted: isCompleted == null && nullToAbsent
          ? const Value.absent()
          : Value(isCompleted),
    );
  }

  factory UserTodoTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTodoTableData(
      userId: serializer.fromJson<int?>(json['userId']),
      todoId: serializer.fromJson<int>(json['todoId']),
      todoTitle: serializer.fromJson<String?>(json['todoTitle']),
      isCompleted: serializer.fromJson<bool?>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int?>(userId),
      'todoId': serializer.toJson<int>(todoId),
      'todoTitle': serializer.toJson<String?>(todoTitle),
      'isCompleted': serializer.toJson<bool?>(isCompleted),
    };
  }

  UserTodoTableData copyWith(
          {Value<int?> userId = const Value.absent(),
          int? todoId,
          Value<String?> todoTitle = const Value.absent(),
          Value<bool?> isCompleted = const Value.absent()}) =>
      UserTodoTableData(
        userId: userId.present ? userId.value : this.userId,
        todoId: todoId ?? this.todoId,
        todoTitle: todoTitle.present ? todoTitle.value : this.todoTitle,
        isCompleted: isCompleted.present ? isCompleted.value : this.isCompleted,
      );
  @override
  String toString() {
    return (StringBuffer('UserTodoTableData(')
          ..write('userId: $userId, ')
          ..write('todoId: $todoId, ')
          ..write('todoTitle: $todoTitle, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, todoId, todoTitle, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTodoTableData &&
          other.userId == this.userId &&
          other.todoId == this.todoId &&
          other.todoTitle == this.todoTitle &&
          other.isCompleted == this.isCompleted);
}

class UserTodoTableCompanion extends UpdateCompanion<UserTodoTableData> {
  final Value<int?> userId;
  final Value<int> todoId;
  final Value<String?> todoTitle;
  final Value<bool?> isCompleted;
  const UserTodoTableCompanion({
    this.userId = const Value.absent(),
    this.todoId = const Value.absent(),
    this.todoTitle = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  UserTodoTableCompanion.insert({
    this.userId = const Value.absent(),
    this.todoId = const Value.absent(),
    this.todoTitle = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  static Insertable<UserTodoTableData> custom({
    Expression<int>? userId,
    Expression<int>? todoId,
    Expression<String>? todoTitle,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (todoId != null) 'todo_id': todoId,
      if (todoTitle != null) 'todo_title': todoTitle,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  UserTodoTableCompanion copyWith(
      {Value<int?>? userId,
      Value<int>? todoId,
      Value<String?>? todoTitle,
      Value<bool?>? isCompleted}) {
    return UserTodoTableCompanion(
      userId: userId ?? this.userId,
      todoId: todoId ?? this.todoId,
      todoTitle: todoTitle ?? this.todoTitle,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (todoId.present) {
      map['todo_id'] = Variable<int>(todoId.value);
    }
    if (todoTitle.present) {
      map['todo_title'] = Variable<String>(todoTitle.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTodoTableCompanion(')
          ..write('userId: $userId, ')
          ..write('todoId: $todoId, ')
          ..write('todoTitle: $todoTitle, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $UserPostTableTable userPostTable = $UserPostTableTable(this);
  late final $UserTodoTableTable userTodoTable = $UserTodoTableTable(this);
  late final UserPostTableDao userPostTableDao =
      UserPostTableDao(this as AppDatabase);
  late final UserTodoTableDao userTodoTableDao =
      UserTodoTableDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [userPostTable, userTodoTable];
}
