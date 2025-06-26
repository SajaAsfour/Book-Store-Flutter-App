// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/features/home/presentation/ui/widgets/flash_sale.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:flutter/material.dart';

class FlashSaleScreen extends StatelessWidget {
  final List<ProductModel> books;

  const FlashSaleScreen({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final flashBooks = books.where((book) => book.discount > 0).toList();

    return Scaffold(
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
        title: TitleText(title: "Flash Sale"),
      ),
      body: FlashSale(flashBooks: flashBooks)
    );
  }
}
