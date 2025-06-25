// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class BestSellerWidget extends StatefulWidget {
  final List<ProductModel> books;

  const BestSellerWidget({super.key, required this.books});

  @override
  State<BestSellerWidget> createState() => _BestSellerWidgetState();
}

class _BestSellerWidgetState extends State<BestSellerWidget> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.45);
  }

  void goToPrevious() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
        _pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void goToNext() {
    if (currentPage < widget.books.length - 1) {
      setState(() {
        currentPage++;
        _pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canGoBack = currentPage > 0;
    final bool canGoNext = currentPage < widget.books.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LabelText(text: "Best Seller", size: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 24),

        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.books.length,
            itemBuilder: (context, index) {
              final book = widget.books[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book.image,
                    fit: BoxFit.cover,
                    width: 119.77,
                    height: 180,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 36,
              width: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.hintColor, width: 1.5),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, size: 16),
                color: canGoBack ? AppColors.blackColor : AppColors.greyColor,
                onPressed: canGoBack ? goToPrevious : null,
              ),
            ),
            SizedBox(width: 16),
            Container(
              height: 36,
              width: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.hintColor, width: 1.5),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, size: 16),
                color: canGoNext ? AppColors.blackColor : AppColors.greyColor,
                onPressed: canGoNext ? goToNext : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
