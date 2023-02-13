part of 'user_cubit.dart';

enum UserStatus { initial, loading, success, failure,timeoutStatus,userStatus,socketStatus }

class UserState extends Equatable {
  final UserStatus status;
  final String? users;
  final Exception? exception;

  const UserState({this.status = UserStatus.initial, this.users , this.exception});

  @override
  // TODO: implement props
  List<Object?> get props => [status,users, exception];

  UserState copyWith({
    UserStatus? status,
    String? users,
    Exception? exception,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      exception: exception ?? this.exception,
    );
  }
}
