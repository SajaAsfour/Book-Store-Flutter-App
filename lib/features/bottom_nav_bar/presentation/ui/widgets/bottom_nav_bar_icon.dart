// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class BottomNavBarIcon extends StatelessWidget {
  final bool isActive;
  final Function()? onTap;
  final IconData icon;
  final String iconText;
  const BottomNavBarIcon(
      {super.key,
      this.isActive = false,
      this.onTap,
      required this.icon,
      required this.iconText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.pinkColor : AppColors.greyColor,
            size: 20,
          ),
          LabelText(text: iconText, size: 10, fontWeight: FontWeight.w400)
        ],
      ),
    );
  }
}
