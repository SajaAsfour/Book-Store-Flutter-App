// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/features/home/presentation/manager/cubit/best_seller_cubit.dart';
import 'package:book_store/features/home/presentation/ui/widgets/best_seller_widget.dart';
import 'package:book_store/features/home/presentation/ui/widgets/recommended_section.dart';
import 'package:book_store/features/home/presentation/ui/widgets/top_search_bar.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BestSellerCubit()..fetchBestSellerBooks(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TopSearchBar(
                onSearchResults: (results) {
                  setState(() {
                    searchResults = results;
                  });
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    if (searchResults.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LabelText(text: "Search Results", size: 16, fontWeight: FontWeight.w600),
                            SizedBox(height: 12),
                            ...searchResults.map(
                              (product) => ListTile(
                                leading: Image.network(product.image, width: 40),
                                title: Text(product.name),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    BlocBuilder<BestSellerCubit, BestSellerState>(
                      builder: (context, state) {
                        if (state is BestSellerLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is BestSellerSuccess) {
                          return Column(
                            children: [
                              BestSellerWidget(books: state.books),
                              SizedBox(height: 24),
                            ],
                          );
                        } else if (state is BestSellerError) {
                          return Center(child: Text(state.message));
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    RecommendedSection(),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
