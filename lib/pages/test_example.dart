//https://www.codewithflutter.com/flutter-fetch-data-from-api-rest-api-example/
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_infinite/models/example_model.dart';
import 'package:interview_infinite/values/strings.dart';

// List<Post2> postFromJson(String str) =>
//     List<Post2>.from(json.decode(str).map((x) => Post2.fromMap(x)));
//
// class Post2 {
//   Post2({
//     // required this.userId,
//     // required this.id,
//     required this.firstName,
//     required this.lastName,
//   });
//
//   // int userId;
//   // int id;
//   String firstName;
//   String lastName;
//
//   factory Post2.fromMap(Map<String, dynamic> json) => Post2(
//         // userId: json["userId"],
//         // id: json["id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//       );
// }
//
// Future<List<Post2>> fetchPost2() async {
//   final response = await http.get(Uri.parse(StringConst.apiUrl));
//
//   if (response.statusCode == 200) {
//     final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//
//     return parsed.map<Post2>((json) => Post2.fromMap(json)).toList();
//   } else {
//     throw Exception('Failed to load album');
//   }
// }

Future<List<Post>> fetchPost() async {
  final response = await http.get(Uri.parse(Const.apiUrl));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class TestExample extends StatefulWidget {
  const TestExample({Key? key}) : super(key: key);

  @override
  _TestExampleState createState() => _TestExampleState();
}

class _TestExampleState extends State<TestExample> {
  late Future<List<Post>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: futurePost,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (_, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xff97FFFF),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data![index].title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(snapshot.data![index].body),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text(snapshot.error.toString());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
