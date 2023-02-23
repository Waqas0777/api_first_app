part of 'user_comment_cubit.dart';

enum UserCommentStatus {
   // searchingStatus,
  initial,
  loading,
  success,
  failure,
  timeoutStatus,
  userStatus,
  socketStatus
}

class UserCommentState extends Equatable {
  final UserCommentStatus status;
  final List<CommentModel>? comModel;
  final Exception? exception;

  const UserCommentState(
      {this.status = UserCommentStatus.initial, this.comModel, this.exception});

  @override
  // TODO: implement props
  List<Object?> get props => [status, comModel, exception];

  UserCommentState copyWith({
    UserCommentStatus? status,
    List<CommentModel>? comModel,
    Exception? exception,
  }) {
    return UserCommentState(
      status: status ?? this.status,
      comModel: comModel ?? comModel,
      exception: exception ?? this.exception,
    );
  }
}
