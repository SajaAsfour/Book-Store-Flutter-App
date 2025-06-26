// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/home/presentation/ui/widgets/flash_sale.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class FlashSaleSection extends StatelessWidget {
  final List<ProductModel> books;

  const FlashSaleSection({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final flashBooks = books.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LabelText(
                  text: "Flash sale", size: 16, fontWeight: FontWeight.w600),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.flashSaleScreen , arguments: books);
                },
                child: Row(
                  children: [
                    LabelText(
                      text: "See all",
                      size: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.pinkColor,
                    ),
                    Icon(Icons.arrow_forward_ios,
                        size: 14, color: AppColors.pinkColor),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 16),
        FlashSale(flashBooks: flashBooks ,scrollPhysics: NeverScrollableScrollPhysics(),)
      ],
    );
  }
}
