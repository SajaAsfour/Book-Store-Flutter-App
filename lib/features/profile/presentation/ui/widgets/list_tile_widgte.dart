// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class ListTileWidgte extends StatelessWidget {
  final String imagePath;
  final String labelText;
  final VoidCallback onTap;
  const ListTileWidgte({
    super.key, required this.imagePath, required this.labelText, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 38,
        height: 38,
        fit: BoxFit.cover,
      ),
      title: LabelText(text: labelText, size: 14, fontWeight: FontWeight.w400),
      trailing:  Icon(Icons.chevron_right, color: AppColors.greyColor),
      onTap: onTap,
    );
  }
}