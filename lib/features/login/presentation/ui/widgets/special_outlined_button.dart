// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class SpecialOutlinedButton extends StatelessWidget {
  final String imageUrl;
  final String text;
  final VoidCallback? onPressed;

  const SpecialOutlinedButton({
    super.key,
    required this.imageUrl,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          imageUrl,
          width: 22,
          height: 22,
        ),
        label: LabelText(
          text: text,
          size: 16,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w400,
        ),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(width: 1, color: AppColors.greyColor),
          minimumSize: Size(163.5, 54),
          visualDensity: VisualDensity(horizontal: 0, vertical: 0),
        ),
      ),
    );
  }
}