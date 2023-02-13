<<<<<<< HEAD
import 'package:api_first_app/users/cubit/user_cubit.dart';
import 'package:api_first_app/users/user_screen.dart';
=======
import 'package:api_first_app/screens/posts/cubit/post_cubit.dart';
import 'package:api_first_app/screens/posts/post_screen.dart';
>>>>>>> e1da34e (Fetched Data from Apis and show its result in a listview.builder in separated cards . and when we click on a specific card we show its result in a details screen.)
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
<<<<<<< HEAD
        BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit()),
=======
        BlocProvider<PostCubit>(create: (BuildContext context) => PostCubit()),
>>>>>>> e1da34e (Fetched Data from Apis and show its result in a listview.builder in separated cards . and when we click on a specific card we show its result in a details screen.)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
<<<<<<< HEAD
        home: const UserScreen(),
=======
        home: const PostScreen(),
>>>>>>> e1da34e (Fetched Data from Apis and show its result in a listview.builder in separated cards . and when we click on a specific card we show its result in a details screen.)
      ),
    );
  }
}
