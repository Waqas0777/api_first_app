import 'package:api_first_app/users/cubit/user_cubit.dart';
import 'package:api_first_app/screens/posts/cubit/post_cubit.dart';
import 'package:api_first_app/screens/posts/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit()),
        BlocProvider<PostCubit>(create: (BuildContext context) => PostCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PostScreen(),
      ),
    );
  }
}
