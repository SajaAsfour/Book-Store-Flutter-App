// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/home/presentation/ui/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

class TopSearchBar extends StatelessWidget {
  const TopSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          // Search Bar
          SearchTextField(
            heightForSizeBox: 16,
            widgetForSizeBox: 39,
          ),
          SizedBox(width: 10),
          CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.pinkColor,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart,
                  color: AppColors.whiteColor,
                  size: 16,
                ),
              )),
          SizedBox(width: 10),
          Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.pinkColor, width: 1.5),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: AppColors.pinkColor,
                  size: 16,
                ),
              )),
        ],
      ),
    );
  }
}
