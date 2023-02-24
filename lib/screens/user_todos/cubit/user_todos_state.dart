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
  final Exception? exception;

  const UserTodosState(
      {this.status = UserTodosStatus.initial, this.todosModel, this.exception});

  @override
  // TODO: implement props
  List<Object?> get props => [status, todosModel, exception];

  UserTodosState copyWith({
    UserTodosStatus? status,
    List<TodosModel>? listTodosModel,
    Exception? exception,
  }) {
    return UserTodosState(
      status: status ?? this.status,
      todosModel: listTodosModel ?? listTodosModel,
      exception: exception ?? this.exception,
    );
  }
}
