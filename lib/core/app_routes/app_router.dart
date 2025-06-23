// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/features/code_verification/presentation/ui/code_verification_screen.dart';
import 'package:book_store/features/create_account/presentation/manager/cubit/create_account_cubit.dart';
import 'package:book_store/features/create_account/presentation/ui/create_account_screen.dart';
import 'package:book_store/features/forget_password/presentation/ui/forget_password_screen.dart';
import 'package:book_store/features/home/presentation/ui/home_screen.dart';
import 'package:book_store/features/login/presentation/ui/login_screen.dart';
import 'package:book_store/features/splash_screen/presentation/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case Routes.createAccountScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => CreateAccountCubit(),
                  child: CreateAccountScreen(),
                ));
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());

      case Routes.codeScreen:
        return MaterialPageRoute(builder: (context) => CodeVerificationScreen());
    }
    return null;
  };
}
