import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/core/services/networking/dio_factory.dart';

class GetBooksRepo {
  static Future<List<ProductModel>> getBestSeller() async {
    try {
      final response = await DioFactory.getRequest(url: 'products-bestseller');
      if (response != null && response.statusCode == 200) {
        final List data = response.data['data']['products']; 
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      throw Exception('Error fetching books: $e');
    }
  }

  static Future<List<ProductModel>> fetchAllProducts() async {
    final response = await DioFactory.getRequest(url: "products");

    if (response != null &&
        response.data != null &&
        response.data["data"] != null) {
      List<dynamic> jsonList = response.data["data"]["products"];
      return jsonList.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  static Future<List<ProductModel>> fetchAllProductsSortedByName() async {
  final response = await DioFactory.getRequest(url: "products");

  if (response != null &&
      response.data != null &&
      response.data["data"] != null) {
    List<dynamic> jsonList = response.data["data"]["products"];
    
    List<ProductModel> products = jsonList.map((e) => ProductModel.fromJson(e)).toList();
    
    products.sort((a, b) => a.name.compareTo(b.name));

    return products;
  } else {
    throw Exception("Failed to load products");
  }
}
}
