import 'package:flutter/material.dart';
import 'package:wp_client/api_browser.dart';
import 'package:wp_client/widgets/post.dart';
import 'package:wp_client/widgets/posts_index.dart';

void main() => runApp(MyApp());
var postsGlobalNavKey = GlobalKey<NavigatorState>();
var browserGlobalNavKey = GlobalKey<NavigatorState>();
var pageNavKeys = [browserGlobalNavKey, postsGlobalNavKey];

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
  PageController pc;
  var currentIndex = 0;
  final pages = <Widget>[
    Navigator(
      key: browserGlobalNavKey,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => APIBrowserView(),
      ),
    ),
    Navigator(
      key: postsGlobalNavKey,
      onGenerateRoute: (settings) {
        print("sub-nav: ${settings.name}");
        if (settings.name == "post") {
          print(
              "route to post!: ${Map<String, dynamic>.from(settings.arguments)["id"]}");
          return MaterialPageRoute(
            builder: (context) => PostView(post: settings.arguments),
          );
        }
        return MaterialPageRoute(
          builder: (context) => PostsIndex(),
        );
      },
    ),
  ];
  final navItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.find_in_page),
      title: Text("API Browser"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.description),
      title: Text("Posts"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: 0, keepPage: true);
    pc.addListener(() => setState(() => currentIndex = pc.page.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await pageNavKeys[currentIndex].currentState.maybePop(),
      child: Scaffold(
        body: PageView(
          controller: pc,
          children: pages,
          onPageChanged: (int page)=>setState(()=> currentIndex = page),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          items: navItems,
          onTap: (i) {
            setState(() {
              currentIndex = i;
            });
            pc.jumpToPage(i);
          },
        ),
      ),
    );
  }
}
