import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../model/shared_preferences_model.dart';
import 'cubit/user_post_cubit.dart';

class UserPostsScreen extends StatefulWidget {

  const UserPostsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  String email = getIt<SharedPreferencesModel>().getLoginEmail().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Posts "),
      ),
      body: BlocBuilder<UserPostCubit, UserPostState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Row(
                  children: [
                    const Text("Username :"),
                    Text(email.toString())
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: const [
                    Text("Email :"),
                    Text(" Incoming Email")
                  ],
                ),
                const SizedBox(height: 20,),

              ],
            ),
          );
        },
      ),
    );
  }
}
