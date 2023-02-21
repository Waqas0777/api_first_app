import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/post_model.dart';
import '../post_detail/post_detail_screen.dart';
import 'cubit/post_cubit.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    // List<PostModel> filter_list = List.from(BlocProvider.of<PostCubit>(context).postList);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Getting Posts From Api "),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: TextField(
                  onChanged: (value) =>
                      BlocProvider.of<PostCubit>(context).onSearch(value),
                  decoration: InputDecoration(
                      labelText: "Search Post ",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(),
                      ),
                      prefixIcon: const Icon(Icons.search)
                      //fillColor: Colors.green
                      ),
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                  // controller: nameController,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  switch (state.status) {
                    case UserStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case UserStatus.initial:
                      return Center(
                        child: CupertinoButton(
                          color: Colors.blue,
                          onPressed: () {
                            BlocProvider.of<PostCubit>(context).fetchPosts();
                          },
                          child: const Text("Fetch Data"),
                        ),
                      );

                    case UserStatus.searchingStatus:
                      return Column(
                        children: [buildSearchViewWidget(context, state)],
                      );
                    case UserStatus.success:
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

                    case UserStatus.failure:
                      return Column(
                        children: [
                          Center(
                            child: CupertinoButton(
                              color: Colors.blue,
                              onPressed: () {
                                BlocProvider.of<PostCubit>(context)
                                    .fetchPosts();
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
                                BlocProvider.of<PostCubit>(context)
                                    .fetchPosts();
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
                                BlocProvider.of<PostCubit>(context)
                                    .fetchPosts();
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
                                BlocProvider.of<PostCubit>(context)
                                    .fetchPosts();
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

  Widget buildSearchViewWidget(BuildContext context, PostState state) {
    return (state.pModel!.isEmpty)
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
            itemCount: state.pModel!.length,
            itemBuilder: (BuildContext context, int index) {
              var post = state.pModel![index];
              return buildSearchCardWidget(post);
            });
  }

  Widget buildSearchCardWidget(PostModel post) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PostDetailScreen(
            id: post.id!,
            model: post,
          );
        }));
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
                        const Text("Id : "),
                        Text(post.id.toString()),
                        // Text(snapshot.data![index].id.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Title : "),
                        Expanded(child: Text(post.title.toString())),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Body : "),
                        Expanded(child: Text(post.body.toString())),
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

  Widget buildListViewWidget(BuildContext context, PostState state) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: state.pModel!.length,
        itemBuilder: (BuildContext context, int index) {
          var post =  BlocProvider.of<PostCubit>(context).postList[index];
          return buildCardWidget(post);
        });
  }

  Widget buildCardWidget(PostModel post) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PostDetailScreen(
            id: post.id!,
            model: post,
          );
        }));
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
                        const Text("Id : "),
                        Text(post.id.toString()),
                        // Text(snapshot.data![index].id.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Title : "),
                        Expanded(child: Text(post.title.toString())),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text("Post Body : "),
                        Expanded(child: Text(post.body.toString())),
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

// onSearch(String value) {
//   log(value, name: "value");
//   //List<PostModel> postModel = BlocProvider.of<PostCubit>(context).postList;
//   List<PostModel> filteredItems = items.where((item) =>
//       item.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
// }
// void updateList(String value){
//   filter_list = post.
// }
}
