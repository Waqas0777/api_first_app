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
  final List<UserPostTableData>? userPostTableDataList;

  // final List<TodosModel>? todosModel;
  final Exception? exception;
  final String? str;

  const UserPostsState(
      {this.status = UserPostsStatus.initial,
      this.postModel,
      this.userPostTableDataList,
      this.exception,
      this.str});

  @override
  // TODO: implement props
  List<Object?> get props => [status, postModel, exception, str];

  UserPostsState copyWith({
    UserPostsStatus? status,
    List<PostModel>? listPostModel,
    List<UserPostTableData>? listUserPostTableData,
    Exception? exception,
    String? str,
  }) {
    return UserPostsState(
      status: status ?? this.status,
      postModel: listPostModel ?? listPostModel,
      userPostTableDataList: listUserPostTableData ?? listUserPostTableData,
      exception: exception ?? this.exception,
      str: str ?? this.str,
    );
  }
}
