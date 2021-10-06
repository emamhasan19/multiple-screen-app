import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multiple_screen/Screens/postDetails.dart';
import 'package:multiple_screen/model/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:multiple_screen/widget/PostCard.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<List<PostModel>> getData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url).then((value) {
      return value.body;
    });

    List<dynamic> postCollection = jsonDecode(response);

    List<PostModel> postData = [];
    postCollection.forEach((element) {
      PostModel singlePost = PostModel.fromJson(element);
      //print(singlePost.title);
      postData.add(singlePost);
    });
    return postData;
  }

  @override
  Widget build(BuildContext context) {
    // if (Platform.isAndroid) {
    //   print("This is an android device");
    // } else {
    //   print("This is not an android device");
    // }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PostModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                PostModel post = snapshot.data[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetails(
                          post: post,
                        ),
                      ),
                    );
                  },
                  child: PostCard(post: post),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
