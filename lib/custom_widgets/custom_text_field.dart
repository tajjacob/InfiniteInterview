import 'package:colour/colour.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.title,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController? controller;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '   $title',
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colour('#32baa5')),
                borderRadius: BorderRadius.circular(30.0),
              ),
              hintText: hintText,
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }
}
