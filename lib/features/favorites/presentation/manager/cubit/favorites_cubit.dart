import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/features/favorites/data/repo/favorites_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore_for_file: prefer_const_constructors

class FavoritesCubit extends Cubit<List<ProductModel>> {
  FavoritesCubit() : super([]) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final email = await SharedPrefsHelper.getData(key: 'user_email') ?? '';
    final favorites = await FavoritesRepo.loadFavorites(email);
    emit(favorites);
  }

  Future<void> _saveFavorites(String email) async {
    await FavoritesRepo.saveFavorites(email, state);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final email = await SharedPrefsHelper.getData(key: 'user_email') ?? '';
    if (email.isEmpty) {
      emit([]); // Ensure no favorites are shown if not logged in
      return;
    }

    final currentFavorites = List<ProductModel>.from(state);

    if (currentFavorites.any((p) => p.id == product.id)) {
      currentFavorites.removeWhere((p) => p.id == product.id);
    } else {
      currentFavorites.add(product);
    }

    emit(currentFavorites);
    await _saveFavorites(email);
  }

  bool isFavorite(ProductModel product) {
    return state.any((p) => p.id == product.id);
  }

  Future<void> onUserChanged() async {
    emit([]); // Clear current favorites
    await _loadFavorites(); // Load favorites for the new user
  }
}