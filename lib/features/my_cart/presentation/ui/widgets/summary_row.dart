// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class SummaryRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           LabelText(text: title, size:  isTotal? 20 :14, fontWeight:  isTotal? FontWeight.w700:FontWeight.w400 , color:isTotal?AppColors.blackColor: AppColors.greyColor,),
           LabelText(text: value, size: isTotal? 20 :14, fontWeight:  isTotal? FontWeight.w700:FontWeight.w400 , color: isTotal?AppColors.pinkColor:AppColors.greyColor,),
        ],
      ),
    );
  }
}
