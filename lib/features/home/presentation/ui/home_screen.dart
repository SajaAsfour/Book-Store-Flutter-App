// ignore_for_file: prefer_const_constructors

import 'package:book_store/features/home/presentation/manager/cubit/best_seller_cubit.dart';
import 'package:book_store/features/home/presentation/ui/widgets/best_seller_widget.dart';
import 'package:book_store/features/home/presentation/ui/widgets/top_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BestSellerCubit()..fetchBestSellerBooks(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TopSearchBar(),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<BestSellerCubit, BestSellerState>(
                  builder: (context, state) {
                    if (state is BestSellerLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is BestSellerSuccess) {
                      return ListView(
                        children: [
                          BestSellerWidget(books: state.books),
                          const SizedBox(height: 24),
                        ],
                      );
                    } else if (state is BestSellerError) {
                      return Center(child: Text(state.message));
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
