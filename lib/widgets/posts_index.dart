import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wp_client/widgets/post_tile.dart';
import 'package:wp_client/constants.dart';
import 'package:http/http.dart' as http;

class PostsIndex extends StatefulWidget {
  PostsIndex({Key key}) : super(key: key);

  _PostsIndexState createState() => _PostsIndexState();
}

class _PostsIndexState extends State<PostsIndex> {
  Future<http.Response> gettingPosts;
  List<dynamic> posts = [];
  @override
  void initState() {
    super.initState();
    gettingPosts = http.get(baseURL + "wp/v2/posts");
  }

  refresh() {
    setState(() {
      gettingPosts = http.get(baseURL + "wp/v2/posts");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: gettingPosts,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            print(
                "snapshot:\n  data: ${snapshot.data}\n  error:${snapshot.error}");
            return Center(child: Text("Loading..."));
          }
          posts = jsonDecode(snapshot.data.body);
          print("building all posts again: $posts");
          return Flex(
            children: [
              ...posts.map((p) => PostTile(post: p)),
            ],
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: refresh,
      ),
    );
  }
}
