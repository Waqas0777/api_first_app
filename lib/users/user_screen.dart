import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/user_cubit.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Getting Users From Api "),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  switch (state.status) {
                    case UserStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case UserStatus.initial:
                      return Center(
                        child: CupertinoButton(
                          color: Colors.blue,
                          onPressed: () {
                            BlocProvider.of<UserCubit>(context).fetchUsers();
                          },
                          child: const Text("Fetch Data"),
                        ),
                      );
                    case UserStatus.success:
                      //state.users.toString()
                      return Column(
                        children: [
                          CupertinoButton(
                            color: Colors.blue,
                            onPressed: () {
                              BlocProvider.of<UserCubit>(context).fetchUsers();
                            },
                            child: const Text("Fetch Data"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(BlocProvider.of<UserCubit>(context)
                              .user
                              .toString()),
                        ],
                      );

                    // return CupertinoButton(
                    //   color: Colors.blue,
                    //   onPressed: () {
                    //     BlocProvider.of<UserCubit>(context).fetchUsers();
                    //   },
                    //   child: const Text("Fetch Data"),
                    // );
                    case UserStatus.failure:
                      return Column(
                        children: [
                          Center(
                            child: CupertinoButton(
                              color: Colors.blue,
                              onPressed: () {
                                BlocProvider.of<UserCubit>(context)
                                    .fetchUsers();
                              },
                              child: const Text("Fetch Data"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(child: Text("Something went wrong"))
                        ],
                      );
                    case UserStatus.socketStatus:
                      return Column(
                        children: [
                          Center(
                            child: CupertinoButton(
                              color: Colors.blue,
                              onPressed: () {
                                BlocProvider.of<UserCubit>(context)
                                    .fetchUsers();
                              },
                              child: const Text("Fetch Data"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(child: Text("No Internet Connection"))
                        ],
                      );
                    case UserStatus.timeoutStatus:
                      return Column(
                        children: [
                          Center(
                            child: CupertinoButton(
                              color: Colors.blue,
                              onPressed: () {
                                BlocProvider.of<UserCubit>(context)
                                    .fetchUsers();
                              },
                              child: const Text("Fetch Data"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(child: Text("Request Timeout Exception"))
                        ],
                      );
                    case UserStatus.userStatus:
                      return Column(
                        children: [
                          Center(
                            child: CupertinoButton(
                              color: Colors.blue,
                              onPressed: () {
                                BlocProvider.of<UserCubit>(context)
                                    .fetchUsers();
                              },
                              child: const Text("Fetch Data"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(child: Text("User Mobile Issue"))
                        ],
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
