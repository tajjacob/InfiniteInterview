import 'package:colour/colour.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 20, 30, 10),
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: Colour('#32baa5'),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
