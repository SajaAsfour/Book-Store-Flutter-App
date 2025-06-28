// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
        title: TitleText(title: "Favorites"),
      ),
      body: BlocBuilder<FavoritesCubit, List<ProductModel>>(
        builder: (context, favorites) {
          if (favorites.isEmpty) {
            return Center(
              child: LabelText(
                text: "No Favorites Yet",
                size: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.pinkColor,
              ),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: AppColors.greyColor),
                  ),
                  tileColor: AppColors.whiteColor,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.bookDetailsScreen,
                          arguments: product.id);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.image,
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: LabelText(
                    text: product.name,
                    size: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: AppColors.pinkColor),
                    onPressed: () {
                      context.read<FavoritesCubit>().toggleFavorite(product);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
