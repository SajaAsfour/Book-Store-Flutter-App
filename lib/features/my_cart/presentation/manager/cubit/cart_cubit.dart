// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:book_store/features/my_cart/data/repo/cart_repo.dart';
import 'package:flutter/material.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo cartRepository;
  final BuildContext context;

  CartCubit(this.cartRepository, this.context) : super(const CartInitial());

  Future<void> addToCart(int productId, int quantity) async {
    emit(const CartLoading());
    final result = await cartRepository.addToCart(productId, quantity);
    if (result['success']) {
      List<int> updatedCart = [];

      if (state is CartSuccess) {
        updatedCart = List<int>.from((state as CartSuccess).cartItems);
      }

      updatedCart.add(productId);

      emit(CartSuccess(
        message: result['message'],
        cartItems: updatedCart,
      ));
    } else {
      emit(CartError(message: result['message']));
    }
  }

  Future<void> fetchCart() async {
    emit(const CartLoading());
    final result = await cartRepository.getCart();
    if (result['success']) {
      final cartData = result['data'] as Map<String, dynamic>;
      final cartItems = (cartData['cart_items'] as List)
          .map((item) => item as Map<String, dynamic>)
          .toList();
      emit(CartLoaded(
        message: result['message'],
        cartItems: cartItems,
        total: cartData['total'] as String,
      ));
    } else {
      emit(CartError(message: result['message']));
    }
  }

  void increaseItemQuantity(int index) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      List<Map<String, dynamic>> updatedItems =
          List.from(currentState.cartItems);

      int currentQty =
          int.tryParse(updatedItems[index]['item_quantity'].toString()) ?? 1;
      updatedItems[index]['item_quantity'] = currentQty + 1;

      double unitPrice = double.tryParse(updatedItems[index]
                  ['item_product_price_after_discount']
              .toString()) ??
          0;
      updatedItems[index]['item_total'] =
          ((currentQty + 1) * unitPrice).toStringAsFixed(2);

      double newTotal = calculateCartTotal(updatedItems);
      emit(CartLoaded(
          message: "Quantity increased",
          cartItems: updatedItems,
          total: newTotal.toStringAsFixed(2)));
    }
  }

  void decreaseItemQuantity(int index) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      List<Map<String, dynamic>> updatedItems =
          List.from(currentState.cartItems);

      int currentQty =
          int.tryParse(updatedItems[index]['item_quantity'].toString()) ?? 1;
      if (currentQty > 1) {
        updatedItems[index]['item_quantity'] = currentQty - 1;

        double unitPrice = double.tryParse(updatedItems[index]
                    ['item_product_price_after_discount']
                .toString()) ??
            0;
        updatedItems[index]['item_total'] =
            ((currentQty - 1) * unitPrice).toStringAsFixed(2);

        double newTotal = calculateCartTotal(updatedItems);
        emit(CartLoaded(
            message: "Quantity decreased",
            cartItems: updatedItems,
            total: newTotal.toStringAsFixed(2)));
      }
    }
  }

  void removeItem(int index) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      List<Map<String, dynamic>> updatedItems =
          List.from(currentState.cartItems)..removeAt(index);
      double newTotal = calculateCartTotal(updatedItems);
      emit(CartLoaded(
          message: "Item removed",
          cartItems: updatedItems,
          total: newTotal.toStringAsFixed(2)));
    }
  }

  void moveToWishlist(int index) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final item = currentState.cartItems[index];

      // 1. نفترض أنك سترسل هذا العنصر إلى الريبو الخاص بالـ wishlist
      // await wishlistRepo.addToWishlist(item['item_product_id']);

      // 2. بعدها نزيله من السلة
      removeItem(index);
    }
  }

  double calculateCartTotal(List<Map<String, dynamic>> items) {
    double total = 0;
    for (var item in items) {
      double itemTotal = double.tryParse(item['item_total'].toString()) ?? 0;
      total += itemTotal;
    }
    return total;
  }
}
