// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../repository/user_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../user_posts/user_comments_screen.dart';
// import 'login_state.dart';
//
//
// class LoginCubit extends Cubit<LoginState> {
//   final UserRepository _userRepository;
//
//   LoginCubit(this._userRepository) : super(const LoginState());
//
//   Future<void> searchUser(BuildContext context,String userEmail,String password) async {
//     emit(state.copyWith(status: LoginStatus.loading));
//
//     try {
//       final bool isExists = await _userRepository.isUserExists(userEmail);
//       if (isExists) {
//         emit(state.copyWith(status: LoginStatus.success));
//
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) {
//               return const UserPostsScreen();
//             }));
//       }
//       else {
//         emit(state.copyWith(status: LoginStatus.failure));
//       }
//     } catch (e) {
//       emit(state.copyWith(status: LoginStatus.failure,));
//       // emit(UserError(e.toString()));
//     }
//   }
// }