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
  final Exception? exception;

  const PostState(
      {this.status = UserStatus.initial, this.postModel, this.exception});

  @override
  // TODO: implement props
  List<Object?> get props => [status, postModel, exception];

  PostState copyWith({
    UserStatus? status,
    List<PostModel>? listPostModel,
    Exception? exception,
  }) {
    return PostState(
      status: status ?? this.status,
      postModel: listPostModel ?? listPostModel,
      exception: exception ?? this.exception,
    );
  }
}
