// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/home/presentation/manager/cubit/recommended_cubit.dart';
import 'package:book_store/features/home/presentation/ui/widgets/recommended_card.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecommendedCubit()..fetchRecommendedBooks(),
      child: BlocBuilder<RecommendedCubit, RecommendedState>(
        builder: (context, state) {
          if (state is RecommendedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RecommendedSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      LabelText(
                          text: "Recommended for you",
                          size: 16,
                          fontWeight: FontWeight.w600),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, Routes.allBooksScreen);
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
                ...state.books.map((book) => RecommendedCard(
                      book: book,
                      imageUrl: book.image,
                      title: book.name,
                      author: book.category,
                      price:
                          double.tryParse(book.priceAfterDiscount.toString()) ??
                              0.0,
                      rating: 4.0,
                      reviewCount: 180,
                      id: book.id,
                    )),
              ],
            );
          } else if (state is RecommendedError) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
