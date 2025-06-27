import 'dart:async';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/home/data/repo/search_repo.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final double heightForSizeBox;
  final double widthForSizeBox;
  final Function(List<ProductModel>) onResults;

  const SearchTextField({
    super.key,
    required this.heightForSizeBox,
    required this.widthForSizeBox,
    required this.onResults,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        SearchRepo.searchProducts(query ,widget);
      } else {
        widget.onResults([]);
      }
    });
  }
  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.hintColor),
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          Expanded(
            child: SizedBox(
              height: widget.heightForSizeBox,
              width: widget.widthForSizeBox,
              child: TextField(
                controller: _controller,
                onChanged: onSearchChanged,
                decoration: InputDecoration( 
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: AppColors.hintColor,
                    fontSize: 12,
                    fontFamily: "Open Sans",
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mic, color: AppColors.greyColor, size: 20),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: AppColors.greyColor,
          ),
          IconButton(
            icon: Icon(Icons.search, color: AppColors.pinkColor, size: 18),
            onPressed: () {
              onSearchChanged(_controller.text);
            },
          ),
        ],
      ),
    );
  }
}
