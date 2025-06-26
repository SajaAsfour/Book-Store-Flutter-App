// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/book_details/presentation/manager/cubit/book_details_cubit.dart';
import 'package:book_store/features/book_details/presentation/manager/cubit/quantity_cubit.dart';
import 'package:book_store/features/book_details/presentation/ui/widgets/inside_box_widget.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsScreen extends StatelessWidget {
  final int bookId;

  const BookDetailsScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => BookDetailsCubit()..fetchBookDetails(bookId)),
        BlocProvider(create: (_) => QuantityCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: 16),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: TitleText(title: "Book Details"),
        ),
        body: BlocBuilder<BookDetailsCubit, BookDetailsState>(
          builder: (context, state) {
            if (state is BookDetailsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BookDetailsSuccess) {
              final book = state.book;
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              book.image,
                              height: 365,
                              width: 254,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.favorite_border,
                                    color: AppColors.blackColor, size: 20),
                                onPressed: () {
                                  // implement favorite action
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: LabelText(
                            text: book.name,
                            size: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            LabelText(
                              text: '4.5',
                              size: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            Icon(Icons.star,
                                color: AppColors.amberColor, size: 16),
                            LabelText(
                              text: '(180)',
                              size: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    LabelText(
                      text: _stripHtmlTags(book.description),
                      size: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            LabelText(
                              text: "\$${book.priceAfterDiscount}",
                              size: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(width: 8),
                            if (book.discount > 0)
                              LabelText(
                                text: "\$${book.price}",
                                size: 14,
                                color: AppColors.greyColor,
                                fontWeight: FontWeight.w600,
                              ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.greyColor),
                          ),
                          child: book.stock > 0
                              ? InsideBoxWidget(
                                  color: AppColors.greenColor!,
                                  text: 'In Stock',
                                  iconData: Icons.check_circle)
                              : InsideBoxWidget(
                                  color: AppColors.redColor,
                                  text: 'Not In Stock',
                                  iconData: Icons.close,
                                ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.greyColor),
                          ),
                          child: InsideBoxWidget(
                              color: AppColors.orangeColor,
                              text: "Discount code: Ne212"),
                        ),
                        SizedBox(width: 5),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.greyColor),
                          ),
                          child: InsideBoxWidget(
                            color: AppColors.greyColor,
                            text: "Free Shipping Today",
                            iconData: Icons.local_shipping,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        LabelText(
                          text: "Book Title: ",
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        Expanded(
                          child: LabelText(
                            text: "${book.name}",
                            size: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        LabelText(
                          text: "Category: ",
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        LabelText(
                          text: "${book.category}",
                          size: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        LabelText(
                          text: "Stock: ",
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        LabelText(
                          text: "${book.stock}",
                          size: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        LabelText(
                          text: "Best Seller Rank: ",
                          size: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        LabelText(
                          text: "#${book.bestSeller}",
                          size: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              );
            } else if (state is BookDetailsError) {
              return Center(child: Text(state.message));
            }
            return SizedBox();
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: BlocBuilder<QuantityCubit, int>(
                    builder: (context, quantity) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () =>
                                context.read<QuantityCubit>().decrement(),
                            icon: Icon(Icons.remove_circle_outline,
                                color: AppColors.pinkColor),
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            onPressed: () =>
                                context.read<QuantityCubit>().increment(),
                            icon: Icon(Icons.add_circle_outline,
                                color: AppColors.pinkColor),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  // Handle Add to Cart
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.pinkColor,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: LabelText(
                  text: "Add to cart",
                  size: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _stripHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
