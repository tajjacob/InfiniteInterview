import 'package:flutter/material.dart';
import 'package:interview_infinite/custom_widgets/contact_card.dart';
import 'package:interview_infinite/models/data.dart';
import 'package:interview_infinite/models/user.dart';
import 'package:interview_infinite/services/dio_client.dart';

class MyContactSingle extends StatefulWidget {
  const MyContactSingle({Key? key}) : super(key: key);

  @override
  _MyContactSingleState createState() => _MyContactSingleState();
}

class _MyContactSingleState extends State<MyContactSingle> {
  final DioClient _client = DioClient();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _client.getUser(id: '2'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          User? userInfo = snapshot.data;
          if (userInfo != null) {
            Data userData = userInfo.data;

            return ContactCard(
              avatar: userData.avatar,
              firstName: userInfo.data.firstName,
              lastName: userInfo.data.lastName,
              email: userData.email,
              onTap: () {},
            );
          }
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text('Error: ${snapshot.error.toString()}');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
