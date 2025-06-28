// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class ButtonForFilterOrSort extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback? onTap;
  const ButtonForFilterOrSort({
    super.key,
    required this.text, required this.iconData, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 39,
        width: 164,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LabelText(
              text: text,
              size: 14,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(width: 6),
            Icon(iconData , size: 18),
          ],
        ),
      ),
    );
  }
}
