// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/features/create_account/presentation/ui/create_account_screen.dart';
import 'package:book_store/features/login/presentation/ui/login_screen.dart';
import 'package:book_store/features/splash_screen/presentation/ui/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case Routes.createAccountScreen:
        return MaterialPageRoute(builder: (context) => CreateAccountScreen());
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
    }
  };
}
