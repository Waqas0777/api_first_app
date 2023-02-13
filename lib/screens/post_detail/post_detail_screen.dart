import 'package:api_first_app/model/post_model.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final int id;
  final PostModel model;

  const PostDetailScreen({
    required this.id,
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late final String id, userId, title, desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Detail Screen"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text("User ID : "),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(widget.model.userId.toString()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Post ID : "),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(widget.model.id.toString()),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Post Title : "),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text(widget.model.title.toString())),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text("Post Description : "),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(child: Text(widget.model.body.toString())),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> getPost() async {
  //   //_postTableData = await getIt<AppDatabase>().postTableDao.getPost(widget.id);
  //
  //   // setState(() {
  //   //   final image =_postTableData.thumbnailImg;
  //   //   bytesImage = _postTableData.thumbnailImg!;
  //   //   titleController.text = _postTableData.postName!;
  //   //   descriptionController.text = _postTableData.postDescription!;
  //   // });
  //
  //   // String userId = widget.id.toString();
  //   String userId = widget.model.userId.toString();
  //
  //   String id = widget.model.id.toString();
  //   String title = widget.model.title.toString();
  //   String postDesc = widget.model.body.toString();
  //   // descriptionController.text = widget.data.postDescription!;
  // }
}
