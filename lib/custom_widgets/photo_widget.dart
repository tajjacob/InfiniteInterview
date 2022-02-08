import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/amico.png',
      // fit: BoxFit.contain,
      height: 300,
      width: double.infinity,
    );
  }
}
