// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight fontWeight;
  const LabelText({
    super.key,
    required this.text,
    required this.size,
    this.color, required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            color: color,
            fontSize: size,
            fontFamily: "Open Sans",
            fontWeight: fontWeight));
  }
}
