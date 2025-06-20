// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;

   TitleText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: "Open Sans",
        fontSize: 16,
        fontWeight: FontWeight.w400
      ),
    );
  }
}