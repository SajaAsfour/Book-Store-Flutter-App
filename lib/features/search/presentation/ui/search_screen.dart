// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/features/home/presentation/ui/widgets/search_text_field.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/search/presentation/ui/widgets/search_results.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel> searchResults = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(title: "Search Screen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchTextField(heightForSizeBox: 16, widthForSizeBox: 39, onResults: (results) {
                  setState(() {
                    searchResults = results;
                  });
                },),
              SizedBox(height: 16),
              if (searchResults.isNotEmpty)
                SearchResults(searchResults: searchResults),
              
            ],
          ),
        ),
      ),
    );
  }
}
