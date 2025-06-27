import 'package:flutter/material.dart';
import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/home/presentation/ui/widgets/rate_book.dart';

class BookItemCard extends StatelessWidget {
  final ProductModel book;

  const BookItemCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.bookDetailsScreen,
                    arguments: book.id,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 246,
                    width: 164,
                    child: Image.network(
                      book.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: 14,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelText(
                  text: book.name,
                  size: 12,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
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
                        color: AppColors.blackColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                RateBook(rating: 4, reviewCount: 180),
                SizedBox(height: 6),
                Row(
                  children: [
                    LabelText(
                      text: "\$${book.price}",
                      size: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    Spacer(),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColors.pinkColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.shopping_cart,
                          size: 16,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: () {
                          // Handle add to cart
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
