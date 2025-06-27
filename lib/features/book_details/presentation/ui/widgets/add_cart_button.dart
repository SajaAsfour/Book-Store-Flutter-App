// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/book_details/presentation/manager/cubit/quantity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCartButton extends StatelessWidget {
  const AddCartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.pinkColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 33,
              width: 110,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: BlocBuilder<QuantityCubit, int>(
                builder: (context, quantity) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            context.read<QuantityCubit>().decrement(),
                        icon: Icon(Icons.remove_circle_outline,
                            color: AppColors.pinkColor),
                        iconSize: 18,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () =>
                            context.read<QuantityCubit>().increment(),
                        icon: Icon(Icons.add_circle_outline,
                            color: AppColors.pinkColor),
                        iconSize: 18,
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle Add to cart
              },
              child: Text(
                "Add to cart",
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
