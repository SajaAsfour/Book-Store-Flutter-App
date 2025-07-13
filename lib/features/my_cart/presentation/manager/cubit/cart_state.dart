part of 'cart_cubit.dart';


@immutable
sealed class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartSuccess extends CartState {
  final String message;
  final List<int> cartItems;
  const CartSuccess({required this.message, required this.cartItems});
}

class CartError extends CartState {
  final String message;
  const CartError({required this.message});
}

class CartUnauthorized extends CartState {
  final String message;
  const CartUnauthorized({required this.message});
}

class CartLoaded extends CartState {
  final String message;
  final List<Map<String, dynamic>> cartItems;
  final String total;

  const CartLoaded({
    required this.message,
    required this.cartItems,
    required this.total,
  });
}
