// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.searchResults,
  });

  final List<ProductModel> searchResults;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelText(
              text: "Search Results",
              size: 16,
              fontWeight: FontWeight.w600),
          SizedBox(height: 12),
          ...searchResults.map(
            (product) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, Routes.bookDetailsScreen,
                    arguments: product.id);
              },
              child: ListTile(
                leading:
                    Image.network(product.image, width: 40),
                title: Text(product.name),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
