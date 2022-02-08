import 'package:cached_network_image/cached_network_image.dart';
import 'package:colour/colour.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.photoUrl,
    required this.radius,
    required this.borderWidth,
  }) : super(key: key);

  final String photoUrl;
  final double radius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colour('#32baa5'),
            width: borderWidth,
          )),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[100],
        backgroundImage:
            photoUrl != null ? CachedNetworkImageProvider(photoUrl) : null,
        child: photoUrl == null
            ? FaIcon(
                FontAwesomeIcons.userAlt,
                color: Colors.greenAccent,
                size: radius,
              )
            : null,
      ),
    );
  }
}
