import 'package:api_first_app/database/db/app_database.dart';
import 'package:api_first_app/model/post_model.dart';
import 'package:api_first_app/screens/user_posts/cubit/user_posts_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import '../../model/shared_preferences_model.dart';

class UserPostsScreen extends StatefulWidget {
  const UserPostsScreen({Key? key}) : super(key: key);

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  int id = getIt<SharedPreferencesModel>().getLoginId("userId").toInt();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // call the handleBackPress method in your cubit
        BlocProvider.of<UserPostsCubit>(context).handleBackPress();
        Navigator.pop(context);
        // return false to prevent the default pop operation
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User Posts Screen"),
        ),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => UserPostsCubit()..getAllPostsById(id),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<UserPostsCubit, UserPostsState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case UserPostsStatus.loading:
                          return const Center(
                              child: CircularProgressIndicator());
                        case UserPostsStatus.initial:
                          return const Center(
                            // child: CupertinoButton(
                            //   color: Colors.blue,
                            //   onPressed: () {
                            //     BlocProvider.of<UserPostsCubit>(context)
                            //         .fetchPostsById(id);
                            //     // .onSearchById(id);
                            //     // Navigator.push(context,
                            //     //     MaterialPageRoute(builder: (context) {
                            //     //   return const UserPostsScreen();
                            //     // }));
                            //   },
                            //   child: const Text("Fetch Post"),
                            // ),
                          );

                      // case UserPostsStatus.searchingStatus:
                      //   return Column(
                      //     //children: [buildSearchViewWidget(context, state)],
                      //   );
                        case UserPostsStatus.success:
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
                              buildListViewWidget(context, state)
                            ],
                          );

                        case UserPostsStatus.failure:
                          return Column(
                            children: [
                              Center(
                                child: CupertinoButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    BlocProvider.of<UserPostsCubit>(context)
                                        .fetchPostsById(id);
                                    //.onSearchById(id);
                                  },
                                  child: const Text("Fetch Post"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Center(
                                  child: Text("Something went wrong"))
                            ],
                          );
                        case UserPostsStatus.socketStatus:
                          return Column(
                            children: const [
                              // Center(
                              //   child: CupertinoButton(
                              //     color: Colors.blue,
                              //     onPressed: () {
                              //       BlocProvider.of<UserPostsCubit>(context)
                              //           .fetchPostsById(id);
                              //       // .onSearchById(id);
                              //     },
                              //     child: const Text("Fetch Post"),
                              //   ),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: Text("No Internet Connection"))
                            ],
                          );
                        case UserPostsStatus.timeoutStatus:
                          return Column(
                            children: [
                              Center(
                                child: CupertinoButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    BlocProvider.of<UserPostsCubit>(context)
                                        .fetchPostsById(id);
                                    // .onSearchById(id);
                                    //onSearchById
                                  },
                                  child: const Text("Fetch Post"),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Center(
                                  child: Text("Request Timeout Exception"))
                            ],
                          );
                        case UserPostsStatus.userStatus:
                          return Column(
                            children: [
                              Center(
                                child: CupertinoButton(
                                  color: Colors.blue,
                                  onPressed: () {
                                    BlocProvider.of<UserPostsCubit>(context)
                                        .fetchPostsById(id);
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
      ),
    );
  }

  // user posts
  Widget buildListViewWidget(BuildContext context, UserPostsState state) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: state.userPostTableDataList!.length,
        itemBuilder: (BuildContext context, int index) {
          var post = BlocProvider
              .of<UserPostsCubit>(context).userPostTableData[index];
              // .postList[index];
          return buildCardWidget(post);
        });
  }

  Widget buildCardWidget(UserPostTableData post) {
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
                        const Text("User ID : "),
                        Text(post.userId.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Id : "),
                        Text(post.postId.toString()),
                        // Text(snapshot.data![index].id.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Title : "),
                        Expanded(child: Text(post.postTitle.toString())),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Body : "),
                        Expanded(child: Text(post.postBody.toString())),
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
