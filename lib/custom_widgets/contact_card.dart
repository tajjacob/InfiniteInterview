import 'package:colour/colour.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:interview_infinite/custom_widgets/avatar.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    Key? key,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.onTap,
  }) : super(key: key);

  final String avatar;
  final String firstName;
  final String lastName;
  final String email;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Avatar(
        radius: 30,
        borderWidth: 0,
        photoUrl: avatar,
      ),
      // CircleAvatar(
      //   radius: 30,
      //   backgroundImage: NetworkImage(avatar),
      // ),
      title: Text('$firstName $lastName'),
      subtitle: Text(email),
      trailing: FaIcon(
        FontAwesomeIcons.paperPlane,
        color: Colour('#32baa5'),
      ),
    );
  }
}
