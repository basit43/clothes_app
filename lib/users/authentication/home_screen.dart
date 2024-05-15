import 'dart:convert';

import 'package:clothes_app/users/authentication/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Post> postList = [];
  Future<List<Post>> fetchPosts() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final response = await http.get(uri);
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map<String, dynamic> i in data) {
        postList.add(Post.fromJson(i));
      }
      return postList;
      // return Post.fromJson(jsonDecode(response.body));
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Calling'),
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text('${postList[index].title.toString()}'),
                      Text('Description}'),
                      Text('${postList[index].body}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
