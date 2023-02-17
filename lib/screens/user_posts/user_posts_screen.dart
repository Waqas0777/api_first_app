import 'package:flutter/material.dart';
class UserPostsScreen extends StatefulWidget {
  const UserPostsScreen({Key? key}) : super(key: key);

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Posts"),
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
