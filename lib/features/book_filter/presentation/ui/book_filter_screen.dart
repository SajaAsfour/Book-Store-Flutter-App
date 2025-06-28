// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/book_filter/data/repo/book_filter.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/splash_screen/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';

class BookFilterScreen extends StatefulWidget {
  const BookFilterScreen({super.key});

  @override
  State<BookFilterScreen> createState() => _BookFilterScreenState();
}

class _BookFilterScreenState extends State<BookFilterScreen> {
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? category;
  double? minPrice;
  double? maxPrice;
  int? bestSeller;

  @override
  Widget build(BuildContext context) {
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
        title: TitleText(title: "Apply Filter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelText(
                  text: 'Book Name',
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), // Radius 8px
                      borderSide: BorderSide(width: 1), // Border 1px
                    ),
                  ),
                  onChanged: (val) => name = val.isEmpty ? null : val,
                ),
                SizedBox(height: 8),
                LabelText(
                  text: 'Category Name',
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), // Radius 8px
                      borderSide: BorderSide(width: 1), // Border 1px
                    ),
                  ),
                  onChanged: (val) => category = val.isEmpty ? null : val,
                ),
                SizedBox(height: 8),
                LabelText(
                  text: 'Min Price',
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), // Radius 8px
                      borderSide: BorderSide(width: 1), // Border 1px
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) =>
                      minPrice = val.isEmpty ? null : double.tryParse(val),
                ),
                SizedBox(height: 8),
                LabelText(
                  text: 'Max Price',
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8), // Radius 8px
                      borderSide: BorderSide(width: 1), // Border 1px
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (val) =>
                      maxPrice = val.isEmpty ? null : double.tryParse(val),
                ),
                SizedBox(height: 24),
                button(
                  backgroundColor: AppColors.pinkColor,
                  foregroundColor: AppColors.whiteColor,
                  buttonText: "Apply Filter",
                  onPressed: () {
                    final filter = BookFilter(
                      name: name,
                      category: category,
                      minPrice: minPrice,
                      maxPrice: maxPrice,
                    );
                    Navigator.pop(context, filter);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
