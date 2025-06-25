// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final double heightForSizeBox;
  final double widgetForSizeBox;
  const SearchTextField({
    super.key, required this.heightForSizeBox, required this.widgetForSizeBox,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 38,
        width: 239,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.hintColor),
        ),
        child: Row(
          children: [
            SizedBox(width: 15),
            Expanded(
              child: SizedBox(
                height: heightForSizeBox,
                width: widgetForSizeBox,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: AppColors.hintColor,
                        fontSize: 12,
                        fontFamily: "Open Sans",
                        fontWeight: FontWeight.w400),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.mic, color: AppColors.greyColor ,size: 20,)),
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppColors.greyColor,
            ),
            IconButton(
              icon: Icon(Icons.search, color: AppColors.pinkColor ,size: 18,),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
