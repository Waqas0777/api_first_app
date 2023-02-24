part of 'user_posts_cubit.dart';

enum UserPostsStatus {
  initial,
  loading,
  success,
  failure,
  timeoutStatus,
  userStatus,
  socketStatus
}


class UserPostsState extends Equatable {
  final UserPostsStatus status;
  final List<PostModel>? postModel;
  // final List<TodosModel>? todosModel;
  final Exception? exception;

  const UserPostsState(
      {this.status = UserPostsStatus.initial, this.postModel, this.exception});

  @override
  // TODO: implement props
  List<Object?> get props => [status, postModel, exception];

  UserPostsState copyWith({
    UserPostsStatus? status,
    List<PostModel>? listPostModel,
    Exception? exception,
  }) {
    return UserPostsState(
      status: status ?? this.status,
      postModel: listPostModel ?? listPostModel,
      exception: exception ?? this.exception,
    );
  }
}
