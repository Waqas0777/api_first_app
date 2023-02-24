part of 'post_cubit.dart';

enum UserStatus {
  searchingStatus,
  initial,
  loading,
  success,
  failure,
  timeoutStatus,
  userStatus,
  socketStatus
}

class PostState extends Equatable {
  final UserStatus status;
  final List<PostModel>? postModel;
  final List<TodosModel>? todosModel;
  final Exception? exception;

  const PostState(
      {this.status = UserStatus.initial,
      this.postModel,
      this.todosModel,
      this.exception});

  @override
  // TODO: implement props
  List<Object?> get props => [status, postModel, todosModel, exception];

  PostState copyWith({
    UserStatus? status,
    List<PostModel>? listPostModel,
    List<TodosModel>? listTodosModel,
    Exception? exception,
  }) {
    return PostState(
      status: status ?? this.status,
      postModel: listPostModel ?? listPostModel,
      todosModel: listTodosModel ?? listTodosModel,
      exception: exception ?? this.exception,
    );
  }
}
