import 'package:api_first_app/database/daos/user_todo_table_dao.dart';
import 'package:api_first_app/screens/login_user/cubit/login_cubit.dart';
import 'package:api_first_app/screens/splash/cubit/splash_cubit.dart';
import 'package:api_first_app/screens/splash/splash_screen.dart';
import 'package:api_first_app/screens/user_comments/cubit/user_comment_cubit.dart';
import 'package:api_first_app/screens/user_posts/cubit/user_posts_cubit.dart';
import 'package:api_first_app/screens/user_todos/cubit/user_todos_cubit.dart';
import 'package:api_first_app/users/cubit/user_cubit.dart';
import 'package:api_first_app/screens/posts/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/db/app_database.dart';
import 'model/shared_preferences_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencyInjection();
  runApp( MyApp());
}

Future<void> initDependencyInjection() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferencesModel>(SharedPreferencesModel(sharedPreferences));
  getIt.registerSingleton<LoginCubit>(LoginCubit());
  getIt.registerSingleton<UserPostsCubit>(UserPostsCubit());
  getIt.registerSingleton<UserTodosCubit>(UserTodosCubit());
  getIt.registerSingleton<AppDatabase>(AppDatabase());

}

final getIt = GetIt.instance;

class MyApp extends StatelessWidget {
   MyApp({super.key});
  int id = getIt<SharedPreferencesModel>().getLoginId("userId").toInt();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit()),
        BlocProvider<PostCubit>(create: (BuildContext context) => PostCubit()),
        BlocProvider<SplashCubit>(create: (BuildContext context) => SplashCubit()),
        BlocProvider<UserPostsCubit>(create: (BuildContext context) => UserPostsCubit()),
       BlocProvider<UserTodosCubit>(create: (BuildContext context) => UserTodosCubit()..getAllTodos(id)),
        BlocProvider<UserCommentCubit>(create: (BuildContext context) => UserCommentCubit()),
        BlocProvider<LoginCubit>(
            create: (BuildContext context) => LoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
