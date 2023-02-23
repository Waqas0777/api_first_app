import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../model/comment_model.dart';
import '../../model/shared_preferences_model.dart';
import '../login_user/login_screen.dart';
import 'cubit/user_comment_cubit.dart';

class UserCommentsScreen extends StatefulWidget {
   const UserCommentsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserCommentsScreen> createState() => _UserCommentsScreenState();
}

class _UserCommentsScreenState extends State<UserCommentsScreen> {
  String email = getIt<SharedPreferencesModel>().getLoginEmail().toString();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("LoggedIn User Comments "),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return logout();
                    });
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Logged In UserEmail : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(email.toString())
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<UserCommentCubit, UserCommentState>(
                  builder: (context, state) {

                    switch (state.status) {


                      // case UserCommentStatus.searchingStatus:
                      //   return Column(
                      //     children: [buildSearchViewWidget(context, state)],
                      //   );
                      case UserCommentStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case UserCommentStatus.initial:
                        return Center(
                          child: CupertinoButton(
                            color: Colors.blue,
                            onPressed: () {
                              BlocProvider.of<UserCommentCubit>(context).filterCommentsByEmail(email.toString());

                                  // .fetchComments();
                            },
                            child: const Text("Fetch Comments"),
                          ),
                        );

                      // case UserCommentStatus.searchingStatus:
                      //   return Column(
                      //     children: [
                      //       Container()
                      //       // buildSearchViewWidget(context,state)
                      //     ],
                      //   );
                      case UserCommentStatus.success:
                        //state.users.toString()
                        log("$UserCommentStatus.success", name: "success");
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
                            buildListViewWidget(context, state),
                          ],
                        );

                      case UserCommentStatus.failure:
                        return Column(
                          children: [
                            Center(
                              child: CupertinoButton(
                                color: Colors.blue,
                                onPressed: () {
                                  BlocProvider.of<UserCommentCubit>(context)
                                      .fetchComments();
                                },
                                child: const Text("Fetch Comments"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(child: Text("Something went wrong"))
                          ],
                        );
                      case UserCommentStatus.socketStatus:
                        return Column(
                          children: [
                            Center(
                              child: CupertinoButton(
                                color: Colors.blue,
                                onPressed: () {
                                  BlocProvider.of<UserCommentCubit>(context)
                                      .filterCommentsByEmail(email.toString());
                                },
                                child: const Text("Fetch Comments"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(child: Text("No Internet Connection"))
                          ],
                        );
                      case UserCommentStatus.timeoutStatus:
                        return Column(
                          children: [
                            Center(
                              child: CupertinoButton(
                                color: Colors.blue,
                                onPressed: () {
                                  BlocProvider.of<UserCommentCubit>(context)
                                      .fetchComments();
                                },
                                child: const Text("Fetch Comments"),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Center(
                                child: Text("Request Timeout Exception"))
                          ],
                        );
                      case UserCommentStatus.userStatus:
                        return Column(
                          children: [
                            Center(
                              child: CupertinoButton(
                                color: Colors.blue,
                                onPressed: () {
                                  BlocProvider.of<UserCommentCubit>(context)
                                      .fetchComments();
                                },
                                child: const Text("Fetch Comments"),
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

  Widget buildListViewWidget(BuildContext context, UserCommentState state) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: state.comModel!.length,
        itemBuilder: (BuildContext context, int index) {
          var post =
              BlocProvider.of<UserCommentCubit>(context).commentList[index];
          return buildCardWidget(post);
        });
  }

  Widget buildCardWidget(CommentModel commModel) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   // return PostDetailScreen(
        //   //   id: commModel.id!,
        //   //   model: commModel,
        //   // );
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
                        const Text(" ID : "),
                        Text(commModel.id.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Id : "),
                        Text(commModel.postId.toString()),
                        // Text(snapshot.data![index].id.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("User Email : "),
                        Text(commModel.email.toString()),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Name : "),
                        Expanded(child: Text(commModel.name.toString())),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Comment Body : "),
                        Expanded(child: Text(commModel.body.toString())),
                      ],
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


  Widget buildSearchViewWidget(BuildContext context, UserCommentState state) {
    return (state.comModel!.isEmpty)
        ? Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffaabbaa),
        ),
        child: const Text(
          "No Such Data Exits",
          style: TextStyle(fontSize: 15, color: Colors.deepPurpleAccent),
        ))
        : ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: state.comModel!.length,
        itemBuilder: (BuildContext context, int index) {
          var post = state.comModel![index];
          return buildSearchCardWidget(post);
        });
  }

  Widget buildSearchCardWidget(CommentModel cModel) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return PostDetailScreen(
        //     id: post.id!,
        //     model: post,
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
                        const Text(" ID : "),
                        Text(cModel.id.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Id : "),
                        Text(cModel.postId.toString()),
                        // Text(snapshot.data![index].id.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Name : "),
                        Expanded(child: Text(cModel.name.toString())),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Email : "),
                        Expanded(child: Text(cModel.email.toString())),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Body : "),
                        Expanded(child: Text(cModel.body.toString())),
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
  Widget logout() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      //this right here
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Are You Sure You Want to logout??",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      getIt<SharedPreferencesModel>().setLoginStatus(
                          false); // prefs.setBool("isLoggedIn", true);
                      //getIt<SharedPreferencesModel>().setLoginEmail("");
                      getIt<SharedPreferencesModel>().removeEmail();
                      getIt<SharedPreferencesModel>().prefs.clear();
                      // BlocProvider.of<RegisteredPostCubit>(context).c
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const LoginScreen();
                          }));
                      //exit(0);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          "Yes",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.green,
                      ),
                      child: const Center(
                        child: Text(
                          "No",
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
