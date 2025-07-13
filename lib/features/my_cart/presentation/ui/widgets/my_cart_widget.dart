// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/my_cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:book_store/features/my_cart/presentation/ui/widgets/summary_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartWidget extends StatelessWidget {
  const MyCartWidget({
    super.key,
  });

  int getTotalQuantity(List<Map<String, dynamic>> items) {
    int totalQty = 0;
    for (var item in items) {
      totalQty += int.tryParse(item['item_quantity'].toString()) ?? 0;
    }
    return totalQty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoaded) {
          return Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(bottom: 140),
                children: [
                  ...state.cartItems.map((item) {
                    int index = state.cartItems.indexOf(item);
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item['item_product_image'],
                                      width: 90,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () => context
                                            .read<CartCubit>()
                                            .removeItem(index),
                                        icon: Icon(Icons.delete_outline,
                                            color: AppColors.greyColor),
                                      ),
                                      IconButton(
                                        onPressed: () => context
                                            .read<CartCubit>()
                                            .moveToWishlist(index),
                                        icon: Icon(Icons.favorite_border,
                                            color: AppColors.greyColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LabelText(
                                        text: item['item_product_name'],
                                        size: 14,
                                        fontWeight: FontWeight.w600),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        LabelText(
                                            text: 'Author: ',
                                            size: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.greyColor),
                                        LabelText(
                                            text: item['item_product_author'] ??
                                                'Unknown',
                                            size: 10,
                                            fontWeight: FontWeight.w400),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    LabelText(
                                        text:
                                            '\$${item['item_product_price_after_discount']}',
                                        size: 18,
                                        fontWeight: FontWeight.w600),
                                    SizedBox(height: 4),
                                    LabelText(
                                        text:
                                            'ASIN: ${item['item_product_asin'] ?? 'N/A'}',
                                        size: 12,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.greyColor),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () => context
                                              .read<CartCubit>()
                                              .decreaseItemQuantity(index),
                                          icon: Icon(
                                              Icons.remove_circle_outline,
                                              color: AppColors.pinkColor),
                                          iconSize: 18,
                                        ),
                                        Text('${item['item_quantity']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        IconButton(
                                          onPressed: () => context
                                              .read<CartCubit>()
                                              .increaseItemQuantity(index),
                                          icon: Icon(Icons.add_circle_outline,
                                              color: AppColors.pinkColor),
                                          iconSize: 18,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SummaryRow(
                            title: "Subtotal", value: "\$${state.total}"),
                        SummaryRow(title: "Shipping", value: "Free Delivery"),
                        SummaryRow(title: "Tax", value: "\$4"),
                        const Divider(),
                        SummaryRow(
                            title: "Total",
                            value:
                                "\$${(double.parse(state.total) + 4).toStringAsFixed(2)}",
                            isTotal: true),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 12,
                left: 24,
                right: 24,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.pinkColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelText(
                            text: "${getTotalQuantity(state.cartItems)} Item",
                            size: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.whiteColor,
                          ),
                          LabelText(
                              text: "\$${(double.parse(state.total) + 4).toStringAsFixed(2)}",
                              size: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.whiteColor),
                        ],
                      ),
                      LabelText(
                        text: "Check Out",
                        size: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor,
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: AppColors.pinkColor,
                            size: 16,
                          ),
                          onPressed: () {
                            // Checkout action
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return Center(child: Text('Cart is empty'));
      },
    );
  }
}
