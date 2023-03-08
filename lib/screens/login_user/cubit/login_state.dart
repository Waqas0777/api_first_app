import 'package:equatable/equatable.dart';
import '../../../model/user_model.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure,
  internetIssue,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final List<UserModel>? userModel;
  final UserModel? logInModel;
  final String? str;
  final Exception? exception;

  const LoginState(
      {this.status = LoginStatus.initial, this.userModel,this.logInModel,this.str, this.exception});

  @override
  // TODO: implement props
  List<Object?> get props => [status,logInModel,userModel,str,exception];

  LoginState copyWith({
    LoginStatus? status,
    List<UserModel>? userModel,
    UserModel? logInModel,
    String? str,
    Exception? exception,
  }) {
    return LoginState(
      status: status ?? this.status,
      userModel: userModel ?? userModel,
      logInModel: logInModel ?? logInModel,
      str: str ?? str,
      exception: exception ?? this.exception,
    );
  }
}
