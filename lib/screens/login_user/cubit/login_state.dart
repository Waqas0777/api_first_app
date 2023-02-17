import 'package:equatable/equatable.dart';
import '../../../model/user_model.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final List<UserModel>? userModel;
  final String? str;
  final Exception? exception;

  const LoginState(
      {this.status = LoginStatus.initial, this.userModel,this.str, this.exception});

  @override
  // TODO: implement props
  List<Object?> get props => [status,userModel,str,exception];

  LoginState copyWith({
    LoginStatus? status,
    List<UserModel>? userModel,
    String? str,
    Exception? exception,
  }) {
    return LoginState(
      status: status ?? this.status,
      userModel: userModel ?? userModel,
      str: str ?? str,
      exception: exception ?? this.exception,
    );
  }
}
