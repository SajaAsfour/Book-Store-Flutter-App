import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/services/networking/dio_factory.dart';

class GetBookDetailsRepo {
  static Future<ProductModel> fetchBookDetails(int id) async {
    try {
      final response = await DioFactory.getRequest(url: 'products/$id');

      if (response != null &&
          response.statusCode == 200 &&
          response.data['data'] != null) {
        return ProductModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load book details');
      }
    } catch (e) {
      throw Exception('Error fetching book details: $e');
    }
  }
}
