// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class FlashSale extends StatelessWidget {
  final ScrollPhysics? scrollPhysics;
  const FlashSale({
    super.key,
    required this.flashBooks,
    this.scrollPhysics,
  });

  final List<ProductModel> flashBooks;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: scrollPhysics,
      shrinkWrap: true,
      itemCount: flashBooks.length,
      separatorBuilder: (_, __) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final book = flashBooks[index];
        final double progress = (100 - book.discount) / 100;
        final double oldPrice = double.tryParse(book.price) ?? 0;
        final double newPrice = book.priceAfterDiscount;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.flashColor,
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.bookDetailsScreen,
                      arguments: book.id);
                },
                child: ClipRRect(
                  child: Image.network(
                    book.image,
                    width: 93,
                    height: 131,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelText(
                      text: book.name,
                      size: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        LabelText(
                          text: "Category: ",
                          size: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                        LabelText(
                          text: "${book.category}",
                          size: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.whiteColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      color: AppColors.amberColor,
                      backgroundColor: AppColors.greyColor,
                      minHeight: 6,
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelText(
                          text: "${book.stock} books left",
                          size: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: AppColors.amberColor, size: 16),
                            LabelText(
                              text: "4.5",
                              size: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            LabelText(
                              text: "\$$oldPrice",
                              size: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greyColor,
                            ),
                            SizedBox(width: 5),
                            LabelText(
                              text: "\$$newPrice",
                              size: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppColors.pinkColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.shopping_cart,
                              color: AppColors.whiteColor, size: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
