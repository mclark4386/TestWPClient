import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_widget/flutter_json_widget.dart';
import 'package:wp_client/constants.dart';

import 'package:http/http.dart' as http;

class APIBrowserView extends StatefulWidget {
  APIBrowserView({Key key}) : super(key: key);

  _APIBrowserViewState createState() => _APIBrowserViewState();
}

class _APIBrowserViewState extends State<APIBrowserView> {
  final urlController = TextEditingController();
  Map<String, dynamic> data = {};

  var selectedValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Browser"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: urlController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              isExpanded: true,
              value: selectedValue,
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  child: Text("Schema(embedded mapping)"),
                  value: "",
                ),
                DropdownMenuItem(
                  child: Text("Posts index"),
                  value: "wp/v2/posts",
                ),
                DropdownMenuItem(
                  child: Text("Categories"),
                  value: "wp/v2/categories",
                ),
                DropdownMenuItem(
                  child: Text("Tags"),
                  value: "wp/v2/tags",
                ),
                DropdownMenuItem(
                  child: Text("Pages"),
                  value: "wp/v2/pages",
                ),
                DropdownMenuItem(
                  child: Text("Comments"),
                  value: "wp/v2/comments",
                ),
                DropdownMenuItem(
                  child: Text("Media"),
                  value: "wp/v2/media",
                ),
                DropdownMenuItem(
                  child: Text("Users"),
                  value: "wp/v2/users",
                ),
                DropdownMenuItem(
                  child: Text("Post Types"),
                  value: "wp/v2/types",
                ),
                DropdownMenuItem(
                  child: Text("Post Statuses"),
                  value: "wp/v2/statuses",
                ),
                DropdownMenuItem(
                  child: Text("Search"),
                  value: "wp/v2/search",
                ),
              ],
              onChanged: (value) {
                urlController.text = "$value";
                setState(() {
                  selectedValue = value;
                });
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: JsonViewerWidget(
                data,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var response = await http.get(baseURL + urlController.text);
          final rawData = jsonDecode(response.body);
          if (rawData is Map) {
            setState(() {
              data = rawData;
            });
          } else {
            setState(() {
              data = {"data": rawData};
            });
          }
        },
        tooltip: 'Go',
        child: Icon(Icons.forward),
      ),
    );
  }
}
