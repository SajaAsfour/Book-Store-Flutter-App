// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class RateBook extends StatelessWidget {
  const RateBook({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  final double rating;
  final int reviewCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          if (index < rating.floor()) {
            return Icon(Icons.star,
                color: AppColors.amberColor, size: 16);
          } else if (index < rating) {
            return Icon(Icons.star_half,
                color: AppColors.amberColor, size: 16);
          } else {
            return Icon(Icons.star_border,
                color: AppColors.amberColor, size: 16);
          }
        }),
        SizedBox(width: 6),
        LabelText(
          text: "($reviewCount \n Review)",
          size: 10,
          fontWeight: FontWeight.w400,
          color: AppColors.greyColor,
        ),
        
      ],
    );
  }
}
