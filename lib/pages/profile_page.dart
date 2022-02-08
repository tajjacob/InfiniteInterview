import 'package:colour/colour.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interview_infinite/custom_widgets/avatar.dart';
import 'package:interview_infinite/custom_widgets/custom_button.dart';
import 'package:interview_infinite/pages/profile_edit_page.dart';
import 'package:interview_infinite/values/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
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
          Const.profileBar,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileEditPage(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        avatar: avatar,
                        id: id,
                      ),
                    ),
                  );
                },
                child: const Text('Edit'),
              ),
            ),
            Avatar(photoUrl: avatar, radius: 60, borderWidth: 4),
            const SizedBox(height: 10),
            Text('$firstName $lastName'),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              color: (Colors.grey[200])!,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(FontAwesomeIcons.envelope,
                      color: Colour('#32baa5'), size: 50),
                  const SizedBox(height: 10),
                  Text(email),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            CustomButton(
              text: 'Send Email',
              onPressed: () async {
                String? encodeQueryParameters(Map<String, String> params) {
                  return params.entries
                      .map((e) =>
                          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                      .join('&');
                }

                final Uri emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: email,
                  query: encodeQueryParameters(
                      <String, String>{'subject': 'Hi $firstName!'}),
                );

                // launch(emailLaunchUri.toString());
                if (!await launch(emailLaunchUri.toString())) {
                  throw 'Could not launch $email';
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
