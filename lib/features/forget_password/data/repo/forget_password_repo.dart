import 'package:book_store/core/services/networking/dio_factory.dart';

class ForgetPasswordRepo {
  static forgetPassword({
    required String email,
  }) async {
    try {
      final response = await DioFactory.PostRequest(url: 'forget-password', data: {
        "email": email,
      }
      );
      return response;
    } catch (e) {
      return e;
    }
  }
}
