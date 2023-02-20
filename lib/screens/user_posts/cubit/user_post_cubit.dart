import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_post_state.dart';

class UserPostCubit extends Cubit<UserPostState> {
  UserPostCubit() : super(UserPostInitial());
}
