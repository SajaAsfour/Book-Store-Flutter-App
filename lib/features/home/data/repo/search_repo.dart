 import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/services/networking/dio_factory.dart';

class SearchRepo {

  static Future<void> searchProducts(String name, dynamic widget) async {
    final response = await DioFactory.getWithQuery(
      url: 'products-search',
      queryParams: {'name': name},
    );

    if (response != null &&
        response.statusCode == 200 &&
        response.data['data'] != null &&
        response.data['data']['products'] != null) {
      final List data = response.data['data']['products'];
      final results = data.map((e) => ProductModel.fromJson(e)).toList();
      widget.onResults(results);
    } else {
      widget.onResults([]);
    }
  }
}