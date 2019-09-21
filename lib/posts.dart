import 'package:flutter/material.dart';
import 'package:wp_client/widgets/posts_index.dart';

class PostsView extends StatelessWidget  {
  
  @override
  Widget build(BuildContext context) {
    return Navigator(onGenerateRoute: (settings) {
      if(settings.name == "post"){

      }
      return MaterialPageRoute(
        builder: (context) => PostsIndex(),
      );
    });
  }
}
