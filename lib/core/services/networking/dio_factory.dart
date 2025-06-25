// ignore_for_file: prefer_const_constructors, unused_field, non_constant_identifier_names

import 'package:dio/dio.dart';

class DioFactory {
  static Dio? _dio;
  
  static init() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://codingarabic.online/api/",
      connectTimeout: Duration(seconds: 30),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ));
  }

  static Future<Response?> PostRequest({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    return await _dio?.post(
      url,
      data: data,
      options: Options(
        validateStatus: (status) => true,
      ),
    );
  }

  static Future<Response?> getRequest({required String url}) async {
    return await _dio?.get(
      url,
      options: Options(
        validateStatus: (status) => true,
      ),
    );
  }
}
