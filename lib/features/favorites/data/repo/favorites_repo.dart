import 'dart:convert';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';

class FavoritesRepo {
  static Future<List<ProductModel>> loadFavorites(String? userEmail) async {
    if (userEmail == null || userEmail.isEmpty) return [];
    final favoritesJson = await SharedPrefsHelper.getData(key: 'favorites_$userEmail');
    if (favoritesJson != null) {
      final List<dynamic> favoritesList = jsonDecode(favoritesJson);
      return favoritesList.map((json) => ProductModel.fromJson(json)).toList();
    }
    return [];
  }

  static Future<void> saveFavorites(String? userEmail, List<ProductModel> favorites) async {
    if (userEmail == null || userEmail.isEmpty) return;
    final favoritesJson = jsonEncode(favorites.map((p) => p.toJson()).toList());
    await SharedPrefsHelper.saveData(key: 'favorites_$userEmail', value: favoritesJson);
  }
}