import 'package:bloc/bloc.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/services/networking/dio_factory.dart';
import 'package:meta/meta.dart';

part 'recommended_state.dart';

class RecommendedCubit extends Cubit<RecommendedState> {
  RecommendedCubit() : super(RecommendedInitial());

  void fetchRecommendedBooks() async {
    emit(RecommendedLoading());

    try {
      final response = await DioFactory.getRequest(url: 'products');

      if (response != null &&
          response.statusCode == 200 &&
          response.data['data'] != null) {
        final List products = response.data['data']['products'];
        final books = products.map((e) => ProductModel.fromJson(e)).toList();
        emit(RecommendedSuccess(books.take(2).toList())); 
      } else {
        emit(RecommendedError('Failed to fetch recommended books.'));
      }
    } catch (e) {
      emit(RecommendedError(e.toString()));
    }
  }
}
