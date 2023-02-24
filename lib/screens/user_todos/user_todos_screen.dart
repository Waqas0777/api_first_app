import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../model/shared_preferences_model.dart';
import '../../model/todos_model.dart';
import 'cubit/user_todos_cubit.dart';

class UserTodosScreen extends StatefulWidget {
  const UserTodosScreen({Key? key}) : super(key: key);

  @override
  State<UserTodosScreen> createState() => _UserTodosScreenState();
}

class _UserTodosScreenState extends State<UserTodosScreen> {
  int id = getIt<SharedPreferencesModel>().getLoginId("userId").toInt();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // call the handleBackPress method in your cubit
        BlocProvider.of<UserTodosCubit>(context).handleBackPress();
        Navigator.pop(context);
        // return false to prevent the default pop operation
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User Todos Screen"),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<UserTodosCubit, UserTodosState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case UserTodosStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case UserTodosStatus.initial:
                        return Center(
                          child: CupertinoButton(
                            color: Colors.blue,
                            onPressed: () {
                              BlocProvider.of<UserTodosCubit>(context)
                                  .fetchTodosById(id);
                              // .onSearchById(id);
                              // Navigator.push(context, MaterialPageRoute(builder: (context){
                              //   return const UserPostsScreen();
                              // }));
                            },
                            child: const Text("Fetch Todos"),
                          ),
                        );

                      // case UserTodosStatus.searchingStatus:
                      //   return Column(
                      //     //children: [buildSearchViewWidget(context, state)],
                      //   );
                      case UserTodosStatus.success:
                        //state.users.toString()
                        return Column(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 5.0, right: 5),
                            //   child: TextField(
                            //     onChanged: (value) =>
                            //         BlocProvider.of<PostCubit>(context)
                            //             .onSearch(value),
                            //     decoration: InputDecoration(
                            //         labelText: "Search Post by Title",
                            //         fillColor: Colors.white,
                            //         border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(25.0),
                            //           borderSide: const BorderSide(),
                            //         ),
                            //         prefixIcon: const Icon(Icons.search)
                            //         //fillColor: Colors.green
                            //         ),
                            //     keyboardType: TextInputType.text,
                            //     style: const TextStyle(
                            //       fontFamily: "Poppins",
                            //     ),
                            //     // controller: nameController,
                            //   ),
                            // ),
                            buildListTodosViewWidget(context, state)
                          ],
                        );

                      case UserTodosStatus.failure:
                        return Column(
                          children: [
                            Center(
                              child: CupertinoButton(
                                color: Colors.blue,
                                onPressed: () {
                                  BlocProvider.of<UserTodosCubit>(context)
                                      .fetchTodosById(id);
                                  // .fetchPostsById(id);
                                  //.onSearchById(id);
                                },
                                child: const Text("Fetch Post"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(child: Text("Something went wrong"))
                          ],
                        );
                      case UserTodosStatus.socketStatus:
                        return Column(
                          children: [
                            Center(
                              child: CupertinoButton(
                                color: Colors.blue,
                                onPressed: () {
                                  BlocProvider.of<UserTodosCubit>(context)
                                      .fetchTodosById(id);
                                  // .fetchPostsById(id);
                                  // .onSearchById(id);
                                },
                                child: const Text("Fetch Post"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(child: Text("No Internet Connection"))
                          ],
                        );
                      case UserTodosStatus.timeoutStatus:
                        return Column(
                          children: [
                            Center(
                              child: CupertinoButton(
                                color: Colors.blue,
                                onPressed: () {
                                  BlocProvider.of<UserTodosCubit>(context)
                                      .fetchTodosById(id);
                                  //.fetchPostsById(id);
                                  // .onSearchById(id);
                                  //onSearchById
                                },
                                child: const Text("Fetch Post"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(child: Text("Request Timeout Exception"))
                          ],
                        );
                      case UserTodosStatus.userStatus:
                        return Column(
                          children: [
                            Center(
                              child: CupertinoButton(
                                color: Colors.blue,
                                onPressed: () {
                                  BlocProvider.of<UserTodosCubit>(context)
                                      .fetchTodosById(id);
                                  // .fetchPostsById(id);
                                  // .onSearchById(id);
                                },
                                child: const Text("Fetch Post"),
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
      ),
    );
  }

  Widget buildListTodosViewWidget(BuildContext context, UserTodosState state) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: state.todosModel!.length,
        itemBuilder: (BuildContext context, int index) {
          var todos = BlocProvider.of<UserTodosCubit>(context).todosList[index];
          return buildTodosCardWidget(todos);
        });
  }

  Widget buildTodosCardWidget(TodosModel todos) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return PostDetailScreen(
        //     id: todos.id!,
        //     model: todos,
        //   );
        // }));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.green,
            style: BorderStyle.solid,
            width: 1.2,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Text(employee.id.toString()),
                    Row(
                      children: [
                        const Text("User ID : "),
                        Text(todos.userId.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Id : "),
                        Text(todos.id.toString()),
                        // Text(snapshot.data![index].id.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Title : "),
                        Expanded(child: Text(todos.title.toString())),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Body : "),
                        Expanded(child: Text(todos.completed.toString())),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
