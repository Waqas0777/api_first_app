import 'dart:async';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../model/shared_preferences_model.dart';
import '../login_user/login_screen.dart';
import '../posts/post_screen.dart';
import '../user_comments/user_comments_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final bool status;
  late final String userEmail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() async {
    status = getIt<SharedPreferencesModel>().getLoginStatus();
    Timer(const Duration(seconds: 1), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
    setState(() {});
  }

  void navigateUser() async {
    if (status == true) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return const PostScreen();
          }));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
            return const LoginScreen();
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/splash.png'),
      ),
    );
  }
}
