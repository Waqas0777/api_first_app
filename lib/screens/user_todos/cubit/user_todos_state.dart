part of 'user_todos_cubit.dart';

enum UserTodosStatus {
  initial,
  loading,
  success,
  failure,
  timeoutStatus,
  userStatus,
  socketStatus
}

class UserTodosState extends Equatable {
  final UserTodosStatus status;
  final List<TodosModel>? todosModel;
  final List<UserTodoTableData>? userTodoTableDataList;
  final Exception? exception;
  final String? str;

  const UserTodosState(
      {this.status = UserTodosStatus.initial, this.todosModel,this.userTodoTableDataList, this.exception,this.str});

  @override
  // TODO: implement props
  List<Object?> get props => [status, todosModel, exception,str];

  UserTodosState copyWith({
    UserTodosStatus? status,
    List<TodosModel>? listTodosModel,
    List<UserTodoTableData>? listUserTodoTableData,
    Exception? exception,
    String? str,
  }) {
    return UserTodosState(
      status: status ?? this.status,
      todosModel: listTodosModel ?? listTodosModel,
      userTodoTableDataList:listUserTodoTableData??listUserTodoTableData,
      exception: exception ?? this.exception,
      str: str ?? this.str,
    );
  }
}
