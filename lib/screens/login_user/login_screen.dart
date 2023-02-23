import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    userEmailController.dispose();
    userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          buildFormWidget(),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<LoginCubit>(context).
                    fetchUsers(context, userEmailController.text.toString());
                  }
                },
                child: const Text("Login"),
              );
            },
          ),
        ],
      )),
    );
  }

  Widget buildFormWidget() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextFormField(
              controller: userEmailController,
              decoration: InputDecoration(
                labelText: "Enter User Email",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Email';
                }
                // else if(!EmailValidator.validate(value)){
                //   return "Please Enter Valid Email";
                // }

                else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: userPasswordController,
              decoration: InputDecoration(
                labelText: "Enter Password",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Password';
                }
                // else if(!EmailValidator.validate(value)){
                //   return "Please Enter Valid Email";
                // }

                else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

//
// switch (state.status) {
// case LoginStatus.initial:
// return Column(
// children: [
// const SizedBox(
// height: 20,
// ),
//
// buildFormWidget(),
// const SizedBox(
// height: 10,
// ),
//
// CupertinoButton(
// color: Colors.blue,
// onPressed: () {
// if (_formKey.currentState!.validate()) {
// BlocProvider.of<LoginCubit>(context).searchUser(
// context,
// userEmailController.text.trim(),
// userPasswordController.text.trim(),
// );
// // Navigator.of(context)
// //     .pushReplacement(MaterialPageRoute(builder: (context) {
// //   return const MyPostsScreen();
// // }));
// }
// // Navigator.push(context, MaterialPageRoute(builder: (context){
// //   return UpdateEmployeeScreen();
// // }));
// },
// child: const Text("Login"),
// ),
//
//
// ],
// );
// case LoginStatus.loading:
// return const Center(child: CircularProgressIndicator());
// case LoginStatus.success:
// return Column(
// children: [
// const SizedBox(
// height: 20,
// ),
//
// buildFormWidget(),
// const SizedBox(
// height: 10,
// ),
//
// CupertinoButton(
// color: Colors.blue,
// onPressed: () {
// if (_formKey.currentState!.validate()) {
// BlocProvider.of<LoginCubit>(context).searchUser(
// context,
// userEmailController.text.trim(),
// userPasswordController.text.trim(),
// );
// // Navigator.of(context)
// //     .pushReplacement(MaterialPageRoute(builder: (context) {
// //   return const MyPostsScreen();
// // }));
// }
// // Navigator.push(context, MaterialPageRoute(builder: (context){
// //   return UpdateEmployeeScreen();
// // }));
// },
// child: const Text("Login"),
// ),
//
//
// ],
// );
// case LoginStatus.failure:
// return const Text("Failed Loading data");
// }
