// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';

class PaginatedFlashSale extends StatefulWidget {
  final List<ProductModel> flashBooks;

  const PaginatedFlashSale({super.key, required this.flashBooks});

  @override
  State<PaginatedFlashSale> createState() => _PaginatedFlashSaleState();
}

class _PaginatedFlashSaleState extends State<PaginatedFlashSale> {
  int currentPage = 0;
  final int itemsPerPage = 3;

  List<ProductModel> get currentBooks {
    final start = currentPage * itemsPerPage;
    final end = start + itemsPerPage;
    return widget.flashBooks.sublist(
      start,
      end > widget.flashBooks.length ? widget.flashBooks.length : end,
    );
  }

  int get totalPages => (widget.flashBooks.length / itemsPerPage).ceil();

  void nextPage() {
    if (currentPage < totalPages - 1) {
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      setState(() => currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: currentBooks.length,
            separatorBuilder: (_, __) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final book = currentBooks[index];
              final double progress = (100 - book.discount) / 100;
              final double oldPrice = double.tryParse(book.price) ?? 0;
              final double newPrice = book.priceAfterDiscount;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.flashColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book.image,
                        width: 93,
                        height: 131,
                        fit: BoxFit.cover,
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
                            overflow: TextOverflow.ellipsis,
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
                              Expanded(
                                child: LabelText(
                                  text: "${book.category}",
                                  size: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.whiteColor,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                                    color: Colors.white, size: 16),
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
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios ,size: 16,),
              onPressed: currentPage > 0 ? previousPage : null,
              color: currentPage > 0
                  ? AppColors.pinkColor
                  : AppColors.greyColor,
            ),
             LabelText(
                      text: "Previous",
                      size: 14,
                      fontWeight: FontWeight.w600,
                      color:  currentPage > 0
                          ? AppColors.pinkColor
                          : AppColors.greyColor,
                    ),
            ...List.generate(totalPages, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: TextButton(
                    onPressed: () => setState(() => currentPage = index),
                    style: TextButton.styleFrom(
                      backgroundColor: currentPage == index
                          ? AppColors.pinkColor
                          : AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: currentPage == index
                            ? AppColors.whiteColor
                            : AppColors.pinkColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
            LabelText(
                      text: "Next",
                      size: 14,
                      fontWeight: FontWeight.w600,
                      color:  currentPage < totalPages - 1
                          ? AppColors.pinkColor
                          : AppColors.greyColor,
                    ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios,size: 16,),
              onPressed:
                  currentPage < totalPages - 1 ? nextPage : null,
              color: currentPage < totalPages - 1
                  ? AppColors.pinkColor
                  : AppColors.greyColor,
            ),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
