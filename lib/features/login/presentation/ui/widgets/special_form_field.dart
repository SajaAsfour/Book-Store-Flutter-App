// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:book_store/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SpecialFormField extends StatefulWidget {
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;

  const SpecialFormField({
    super.key,
    required this.hint,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  State<SpecialFormField> createState() => _SpecialFormFieldState();
}

class _SpecialFormFieldState extends State<SpecialFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 44,
      child: TextFormField(
        obscureText: widget.obscureText ? _isObscure : false,
        decoration: InputDecoration(
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.hintColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : widget.suffixIcon,
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: AppColors.hintColor,
            fontFamily: "Open Sans",
            fontSize: 12,
            height: 2,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // Radius 8px
            borderSide: BorderSide(width: 1), // Border 1px
          ),
          
        ),
      ),
    );
  }
}