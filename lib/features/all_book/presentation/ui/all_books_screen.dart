// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/features/all_book/presentation/ui/widgets/button_for_filter_or_sort.dart';
import 'package:book_store/features/book_filter/data/repo/book_filter.dart';
import 'package:book_store/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:book_store/features/home/presentation/ui/widgets/search_text_field.dart';
import 'package:book_store/features/search/presentation/ui/widgets/search_results.dart';
import 'package:flutter/material.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/features/all_book/data/repo/get_books_repo.dart';
import 'package:book_store/features/home/presentation/ui/widgets/rate_book.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  List<ProductModel> allBooks = [];
  List<ProductModel> searchResults = [];

  int currentPage = 0;
  final int itemsPerPage = 6;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    try {
      final books = await GetBooksRepo.fetchAllProducts();
      setState(() {
        allBooks = books;
      });
    } catch (e) {
      log("Error loading books: $e");
    }
  }

  List<ProductModel> get currentBooks {
    final start = currentPage * itemsPerPage;
    final end = start + itemsPerPage;
    return allBooks.sublist(
        start, end > allBooks.length ? allBooks.length : end);
  }

  int get totalPages => (allBooks.length / itemsPerPage).ceil();

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
        title: TitleText(title: "Books"),
      ),
      body: allBooks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SearchTextField(
                    heightForSizeBox: 16,
                    widthForSizeBox: 39,
                    onResults: (results) {
                      setState(() {
                        searchResults = results;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  if (searchResults.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: ButtonForFilterOrSort(
                              text: 'Filter',
                              iconData: (Icons.filter_alt_outlined),
                              onTap: () async {
                                final filter = await Navigator.pushNamed(
                                  context,
                                  Routes.bookFilterScreen,
                                ) as BookFilter?;

                                if (filter != null) {
                                  final filtered = allBooks.where((book) {
                                    final matchesName = filter.name == null ||
                                        book.name.toLowerCase().contains(
                                            filter.name!.toLowerCase());
                                    final matchesCategory =
                                        filter.category == null ||
                                            book.category.toLowerCase() ==
                                                filter.category!.toLowerCase();
                                    final matchesMinPrice = filter.minPrice ==
                                            null ||
                                        double.tryParse(book.price) != null &&
                                            double.tryParse(book.price)! >=
                                                filter.minPrice!;

                                    final matchesMaxPrice = filter.maxPrice ==
                                            null ||
                                        double.tryParse(book.price) != null &&
                                            double.tryParse(book.price)! <=
                                                filter.maxPrice!;

                                    return matchesName &&
                                        matchesCategory &&
                                        matchesMinPrice &&
                                        matchesMaxPrice;
                                  }).toList();

                                  setState(() {
                                    allBooks = filtered;
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                              child: ButtonForFilterOrSort(
                            text: 'Sort (A to Z)',
                            iconData: Icons.swap_vert,
                            onTap: () async {
                              List<ProductModel> sortedProducts =
                                  await GetBooksRepo
                                      .fetchAllProductsSortedByName();
                              setState(() {
                                allBooks = sortedProducts;
                              });
                            },
                          )),
                        ],
                      ),
                    ),
                  if (searchResults.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: SearchResults(searchResults: searchResults),
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: currentBooks.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 164 / 390,
                              ),
                              itemBuilder: (context, index) {
                                final book = currentBooks[index];
                                return Container(
                                  width: 164,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          BlocBuilder<FavoritesCubit,
                                                  List<ProductModel>>(
                                              builder: (context, favorites) {
                                                final isFav = context.read<FavoritesCubit>().isFavorite(book);

                                            return Positioned(
                                              top: 8,
                                              left: 8,
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: IconButton(onPressed: (){
                                                    context.read<FavoritesCubit>().toggleFavorite(book);
                                                }, icon: Icon(
                                                  isFav ? Icons.favorite : Icons.favorite_border,
                                                  size: 14,
                                                  color: isFav ? AppColors.pinkColor: AppColors.blackColor,
                                                ),) 
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.0, vertical: 4),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            RateBook(
                                                rating: 4, reviewCount: 180),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: IconButton(
                                                    padding: EdgeInsets.zero,
                                                    icon: Icon(
                                                      Icons.shopping_cart,
                                                      size: 16,
                                                      color:
                                                          AppColors.whiteColor,
                                                    ),
                                                    onPressed: () {},
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
                              },
                            ),
                          ),
                          SizedBox(height: 12),
                          buildPagination(),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget buildPagination() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 16),
          onPressed: currentPage > 0 ? previousPage : null,
          color: currentPage > 0 ? AppColors.pinkColor : AppColors.greyColor,
        ),
        LabelText(
          text: "Previous",
          size: 14,
          fontWeight: FontWeight.w600,
          color: currentPage > 0 ? AppColors.pinkColor : AppColors.greyColor,
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
          color: currentPage < totalPages - 1
              ? AppColors.pinkColor
              : AppColors.greyColor,
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios, size: 16),
          onPressed: currentPage < totalPages - 1 ? nextPage : null,
          color: currentPage < totalPages - 1
              ? AppColors.pinkColor
              : AppColors.greyColor,
        ),
      ],
    );
  }
}
