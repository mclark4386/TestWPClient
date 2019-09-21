import 'package:flutter/material.dart';
import 'package:wp_client/api_browser.dart';
import 'package:wp_client/posts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: 'Wordpress Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pc = PageController(initialPage: 0);
  var currentIndex =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: pc,
        children: <Widget>[
          APIBrowserView(),
          PostsView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            title: Text("API Browser"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text("Posts"),
          ),
        ],
        onTap: (i){
          pc.jumpToPage(i);
          setState(() {
          currentIndex = i;
          });
        },
      ),
    );
  }
}
