import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/features/book_details/data/repo/get_book_details_repo.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsInitial());

  void fetchBookDetails(int id) async {
    emit(BookDetailsLoading());
    try {
      final book = await GetBookDetailsRepo.fetchBookDetails(id);
      emit(BookDetailsSuccess(book));
    } catch (e) {
      emit(BookDetailsError(e.toString()));
    }
  }
}
