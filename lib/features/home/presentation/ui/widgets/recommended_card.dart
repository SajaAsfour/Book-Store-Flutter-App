// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:book_store/features/home/presentation/ui/widgets/rate_book.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedCard extends StatelessWidget {
  final ProductModel book; 
  final String imageUrl;
  final String title;
  final String author;
  final double price;
  final double rating;
  final int reviewCount;
  final int id;
  const RecommendedCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.id, required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.bookDetailsScreen, arguments: id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
        ),
        child: Row(
          children: [
            ClipRRect(
              child: Image.network(
                imageUrl,
                width: 93,
                height: 124,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelText(text: title, size: 14, fontWeight: FontWeight.w600),
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
                        text: "$author",
                        size: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  RateBook(rating: rating, reviewCount: reviewCount),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      LabelText(
                          text: "\$${price.toStringAsFixed(2)}",
                          size: 18,
                          fontWeight: FontWeight.w600),
                      Spacer(),
                      Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: AppColors.pinkColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.shopping_cart,
                                color: AppColors.whiteColor, size: 16),
                          )),
                      SizedBox(width: 8),
                      BlocBuilder<FavoritesCubit, List<ProductModel>>(
                        builder: (context, state) {
                          final isFav = context.read<FavoritesCubit>().isFavorite(book);
                          return Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.pinkColor, width: 1.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  context.read<FavoritesCubit>().toggleFavorite(book);
                                },
                                icon: Icon( isFav ? Icons.favorite : Icons.favorite_border,
                                    color: AppColors.pinkColor, size: 16),
                              ));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
