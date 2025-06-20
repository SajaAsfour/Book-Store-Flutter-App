// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SpecialTextButton extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  const SpecialTextButton({
    super.key, required this.text, required this.size, required this.color, required this.fontWeight, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,
          style: TextStyle(
            color: color,
            fontFamily: "Open Sans",
            fontSize: size,
            fontWeight: fontWeight
          )),
    );
  }
}
