// ignore_for_file: prefer_const_constructors
import 'package:book_store/core/services/networking/dio_factory.dart';

class CartRepo {
  Future<Map<String, dynamic>> addToCart(int productId, int quantity) async {
    try {
      final response = await DioFactory.PostRequest(
        url: 'add-to-cart',
        data: {
          'product_id': productId,
          'quantity': quantity,
        },
      );

      if (response?.statusCode == 201) {
        return {
          'success': true,
          'message': response?.data['message'] ?? 'Product Added To Cart',
          'data': response?.data['data'],
        };
      }else {
        return {
          'success': false,
          'message': response?.data['message'] ?? 'Failed to add product to cart',
          'error': response?.data['error'] ?? [],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
        'error': [e.toString()],
      };
    }
  }

  Future<Map<String, dynamic>> getCart() async {
    try {
      final response = await DioFactory.getRequest(url: 'cart');

      if (response?.statusCode == 200) {
        return {
          'success': true,
          'message': response?.data['message'] ?? 'Cart fetched successfully',
          'data': response?.data['data'],
        };
      } else if (response?.statusCode == 401) {
        return {
          'success': false,
          'message': 'No Pprodcut in the cart',
          'error': ['Unauthorized'],
        };
      } else {
        return {
          'success': false,
          'message': response?.data['message'] ?? 'Failed to fetch cart',
          'error': response?.data['error'] ?? [],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
        'error': [e.toString()],
      };
    }
  }
}