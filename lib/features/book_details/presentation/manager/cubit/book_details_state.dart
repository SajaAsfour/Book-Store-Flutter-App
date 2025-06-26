part of 'book_details_cubit.dart';

@immutable
abstract class BookDetailsState {}

class BookDetailsInitial extends BookDetailsState {}

class BookDetailsLoading extends BookDetailsState {}

class BookDetailsSuccess extends BookDetailsState {
  final ProductModel book;
  BookDetailsSuccess(this.book);
}

class BookDetailsError extends BookDetailsState {
  final String message;
  BookDetailsError(this.message);
}
