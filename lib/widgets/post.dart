import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PostView extends StatelessWidget {
  final Map post;
  const PostView({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      return Center(
        child: Text("BAD!!!"),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Post: ${post["title"]["rendered"]}"),
      ),
      body: Container(
        child: HtmlWidget("${post["content"]["rendered"]}"),
      ),
    );
  }
}
