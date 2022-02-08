import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:interview_infinite/custom_widgets/contact_list.dart';
import 'package:interview_infinite/custom_widgets/photo_widget.dart';
import 'package:interview_infinite/models/reqres.dart';
import 'package:interview_infinite/values/strings.dart';

class MyContactList extends StatefulWidget {
  const MyContactList({Key? key}) : super(key: key);

  @override
  _MyContactListState createState() => _MyContactListState();
}

class _MyContactListState extends State<MyContactList> {
  Regres? regres;
  List<Data>? dataList;

  Future<List<Data>?> getUserList() async {
    final response = await http.get(Uri.parse(Const.contactApiUrl));
    if (response.statusCode == 200) {
      regres = Regres.fromJson(jsonDecode(response.body));
      setState(() {
        dataList = regres!.data;
      });
      return dataList;
    } else {
      dataList = null;
    }
  }

  @override
  void initState() {
    getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Data>?>(
        future: getUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred! ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ContactList(dataList: dataList);
          } else if (!snapshot.hasData) {
            return const PhotoWidget();
          } else {
            return const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
