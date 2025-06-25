part of 'recommended_cubit.dart';

@immutable
abstract class RecommendedState {}

class RecommendedInitial extends RecommendedState {}

class RecommendedLoading extends RecommendedState {}

class RecommendedSuccess extends RecommendedState {
  final List<ProductModel> books;

  RecommendedSuccess(this.books);
}

class RecommendedError extends RecommendedState {
  final String message;

  RecommendedError(this.message);
}
