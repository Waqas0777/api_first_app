part of 'post_cubit.dart';

enum UserStatus {
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
  final List<PostModel>? pModel;
  final Exception? exception;

  const PostState(
      {this.status = UserStatus.initial, this.pModel, this.exception});

  @override
  // TODO: implement props
  List<Object?> get props => [status, pModel, exception];

  PostState copyWith({
    UserStatus? status,
    List<PostModel>? pModel,
    Exception? exception,
  }) {
    return PostState(
      status: status ?? this.status,
      pModel: pModel ?? pModel,
      exception: exception ?? this.exception,
    );
  }
}
