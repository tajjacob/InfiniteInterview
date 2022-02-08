import 'package:flutter/material.dart';
import 'package:interview_infinite/custom_widgets/avatar.dart';
import 'package:interview_infinite/custom_widgets/custom_button.dart';
import 'package:interview_infinite/custom_widgets/custom_text_field.dart';
import 'package:interview_infinite/models/user_info.dart';
import 'package:interview_infinite/services/dio_client.dart';
import 'package:interview_infinite/values/strings.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({
    Key? key,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.id,
  }) : super(key: key);

  final String avatar;
  final String firstName;
  final String lastName;
  final String email;
  final String id;

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late String _avatar = widget.avatar;
  late String _firstName = widget.firstName;
  late String _lastName = widget.lastName;
  late String _email = widget.email;
  late String _id = widget.id;

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _idController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;

  final DioClient _dioClient = DioClient();

  bool isUpdating = false;

  @override
  void initState() {
    _idController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    super.initState();
    _avatar = widget.avatar;
    _firstName = widget.firstName;
    _lastName = widget.lastName;
    _email = widget.email;
    _id = widget.id;
  }

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
          Const.profileEditBar,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Avatar(
                photoUrl: _avatar,
                radius: 60,
                borderWidth: 4,
              ),
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
              const SizedBox(height: 16.0),
              isUpdating
                  ? CircularProgressIndicator()
                  : CustomButton(
                      text: 'Done',
                      onPressed: () async {
                        setState(() {
                          isUpdating = true;
                        });

                        if (_firstNameController.text != '' &&
                            _lastNameController.text != '') {
                          UserInfo userInfo = UserInfo(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            id: _id.toString(),
                            avatar: _avatar,
                          );

                          UserInfo? retrievedUser = await _dioClient.updateUser(
                            userInfo: userInfo,
                            id: _idController.text,
                          );

                          if (retrievedUser != null) {
                            showDialog(
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
                                        Text('Contact Done Edited:'),
                                        Text(
                                            'Name: ${retrievedUser.firstName} ${retrievedUser.lastName}'),
                                        Text('Email: ${retrievedUser.email}'),
                                        Text(
                                          'Updated at: ${retrievedUser.updatedAt}',
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
                          isUpdating = false;
                        });
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
