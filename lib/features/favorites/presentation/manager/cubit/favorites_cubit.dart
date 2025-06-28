import 'package:book_store/core/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<List<ProductModel>> {
  FavoritesCubit() : super([]);

  void toggleFavorite(ProductModel product) {
    final currentFavorites = List<ProductModel>.from(state);

    if (currentFavorites.any((p) => p.id == product.id)) {
      currentFavorites.removeWhere((p) => p.id == product.id);
    } else {
      currentFavorites.add(product);
    }

    emit(currentFavorites);
  }

  bool isFavorite(ProductModel product) {
    return state.any((p) => p.id == product.id);
  }
}
