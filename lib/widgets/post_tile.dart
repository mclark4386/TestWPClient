import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PostTile extends StatelessWidget {
  final Map<String, dynamic> post;
  const PostTile({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("post: $post");
    return Flexible(
      child: GestureDetector(
        onTap: () {
          print("sub nav to post ${post["id"]}");
          // postsGlobalNavKey.currentState
          Navigator.of(context).pushNamed("post", arguments: post);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Card(
            elevation: 5,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                      colors: <Color>[Colors.redAccent, Colors.yellow]),
                ),
                height: 200,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      HtmlWidget("<h5>${post["title"]["rendered"]}</h5>"),
                      HtmlWidget("${post["content"]["rendered"]}"),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
