import 'package:api_first_app/screens/login_user/cubit/login_cubit.dart';
import 'package:api_first_app/screens/login_user/login_screen.dart';
import 'package:api_first_app/screens/user_posts/cubit/user_post_cubit.dart';
import 'package:api_first_app/users/cubit/user_cubit.dart';
import 'package:api_first_app/screens/posts/cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/shared_preferences_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencyInjection();
  runApp(const MyApp());
}

Future<void> initDependencyInjection() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferencesModel>(SharedPreferencesModel(sharedPreferences));
  getIt.registerSingleton<LoginCubit>(LoginCubit());
}

final getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit()),
        BlocProvider<PostCubit>(create: (BuildContext context) => PostCubit()),
        BlocProvider<UserPostCubit>(create: (BuildContext context) => UserPostCubit()),
        BlocProvider<LoginCubit>(
            create: (BuildContext context) => LoginCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
