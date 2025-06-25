import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/features/home/data/repo/get_books_repo.dart';
import 'package:meta/meta.dart';

part 'best_seller_state.dart';

class BestSellerCubit extends Cubit<BestSellerState> {
  BestSellerCubit() : super(BestSellerInitial());

  Future<void> fetchBestSellerBooks() async {
    emit(BestSellerLoading());
    try {
      final List<ProductModel> books = await GetBooksRepo.getBestSeller();
      emit(BestSellerSuccess(books));
    } catch (e) {
      log(e.toString());
      emit(BestSellerError("Error fetching books"));
    }
  }
}
