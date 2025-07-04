part of 'best_seller_cubit.dart';

@immutable
abstract class BestSellerState {}

class BestSellerInitial extends BestSellerState {}

class BestSellerLoading extends BestSellerState {}

class BestSellerSuccess extends BestSellerState {
  final List<ProductModel> books;

  BestSellerSuccess(this.books);
}

class BestSellerError extends BestSellerState {
  final String message;

  BestSellerError(this.message);
}
