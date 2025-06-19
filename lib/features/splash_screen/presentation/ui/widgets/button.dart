// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

// ignore_for_file: prefer_const_constructors, use_super_parameters, camel_case_types

class button extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String buttonText;
  final String routeName;
  const button({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.buttonText, 
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 343,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(top: 13, right: 16, bottom: 13, left: 16),
        ),
        child: Text(buttonText , style: TextStyle(
          fontFamily: "Open Sans",
          fontSize: 16,
          fontWeight: FontWeight.w600
        ),),
      ),
    );
  }
}