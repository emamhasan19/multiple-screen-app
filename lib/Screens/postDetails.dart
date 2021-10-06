import 'package:flutter/material.dart';
import 'package:multiple_screen/model/post_model.dart';

class PostDetails extends StatelessWidget {
  final PostModel post;

  PostDetails({
    @required this.post,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Title"),
      ),
      body: Column(
        children: [
          Text(
            post.id.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              post.title,
              style: TextStyle(
                fontSize: 20,
              ),
              //textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
