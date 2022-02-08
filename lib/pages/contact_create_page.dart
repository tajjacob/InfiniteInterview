import 'package:flutter/material.dart';
import 'package:interview_infinite/custom_widgets/avatar.dart';
import 'package:interview_infinite/custom_widgets/custom_button.dart';
import 'package:interview_infinite/custom_widgets/custom_text_field.dart';
import 'package:interview_infinite/models/user_info.dart';
import 'package:interview_infinite/services/dio_client.dart';
import 'package:interview_infinite/values/strings.dart';

class ContactCreatePage extends StatefulWidget {
  const ContactCreatePage({Key? key}) : super(key: key);

  @override
  _ContactCreatePageState createState() => _ContactCreatePageState();
}

class _ContactCreatePageState extends State<ContactCreatePage> {
  late final TextEditingController _avatarController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;

  final DioClient _dioClient = DioClient();

  bool isCreating = false;

  @override
  void initState() {
    _avatarController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();

    super.initState();
  }

  final String _photoUrl =
      'https://pngset.com/images/profile-icon-default-profile-picture-person-face-head-people-transparent-png-1112434.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.chevron_left, size: 30, color: Colors.white),
        ),
        title: const Text(
          Const.contactNewBar,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Avatar(photoUrl: _photoUrl, radius: 60, borderWidth: 4),
            CustomTextField(
              controller: _firstNameController,
              title: 'First Name',
              hintText: 'Enter First Name',
            ),
            CustomTextField(
              controller: _lastNameController,
              title: 'Last Name',
              hintText: 'Enter Last Name',
            ),
            CustomTextField(
              controller: _emailController,
              title: 'Email',
              hintText: 'Enter Email',
            ),
            SizedBox(height: 16.0),
            isCreating
                ? const CircularProgressIndicator()
                : CustomButton(
                    text: 'Create Contact',
                    onPressed: () async {
                      setState(() {
                        isCreating = true;
                      });

                      if (_firstNameController.text != '' &&
                          _lastNameController.text != '' &&
                          _emailController.text != '') {
                        UserInfo userInfo = UserInfo(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          email: _emailController.text,
                          // id: retrievedUser.id.toString(),
                          avatar: '',
                        );

                        UserInfo? retrievedUser =
                            await _dioClient.createUser(userInfo: userInfo);
                        // return showDialog(
                        //   context: context,
                        //   builder: (context) => Dialog(
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(20),
                        //       ),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             const Text('New Contact Created:'),
                        //             Text(
                        //                 'Name: ${_firstNameController.text} ${_lastNameController.text}'),
                        //             Text('Email: ${_emailController.text}'),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // );
                        if (retrievedUser != null) {
                          return showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('New Contact Created:'),
                                      Text(
                                          'Name: ${retrievedUser.firstName} ${retrievedUser.lastName}'),
                                      Text('Email: ${retrievedUser.email}'),
                                      Text(
                                        'Created at: ${retrievedUser.createdAt}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }

                      setState(() {
                        isCreating = false;
                      });
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
