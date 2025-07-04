// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/models/product_model.dart';
import 'package:book_store/features/book_details/presentation/ui/book_details_screen.dart';
import 'package:book_store/features/book_filter/presentation/ui/book_filter_screen.dart';
import 'package:book_store/features/bottom_nav_bar/presentation/ui/bottom_nav_bar_screen.dart';
import 'package:book_store/features/code_verification/presentation/ui/code_verification_screen.dart';
import 'package:book_store/features/create_account/presentation/manager/cubit/create_account_cubit.dart';
import 'package:book_store/features/create_account/presentation/ui/create_account_screen.dart';
import 'package:book_store/features/favorites/presentation/ui/favorites_screen.dart';
import 'package:book_store/features/flash_sale/presentation/ui/flash_sale_screen.dart';
import 'package:book_store/features/forget_password/presentation/ui/forget_password_screen.dart';
import 'package:book_store/features/all_book/presentation/ui/all_books_screen.dart';
import 'package:book_store/features/home/presentation/ui/home_screen.dart';
import 'package:book_store/features/login/presentation/ui/login_screen.dart';
import 'package:book_store/features/password_change/presentation/ui/password_change_screen.dart';
import 'package:book_store/features/reset_password/presentation/ui/reset_password_screen.dart';
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
        return MaterialPageRoute(
            builder: (context) => CodeVerificationScreen(
                  email: settings.arguments as String,
                ));

      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(
                  code: settings.arguments as String,
                ));

      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (context) => PasswordChangeScreen());

      case Routes.bottomNavBarScreen:
        return MaterialPageRoute(builder: (context) => BottomNavBarScreen());

      case Routes.allBooksScreen:
        return MaterialPageRoute(builder: (context) => AllBooksScreen());

      case Routes.flashSaleScreen:
        return MaterialPageRoute(builder: (context) => FlashSaleScreen(books: settings.arguments as List<ProductModel>,));
      
      case Routes.bookDetailsScreen:
        return MaterialPageRoute(builder: (context) => BookDetailsScreen(bookId: settings.arguments as int,));

      case Routes.bookFilterScreen:
        return MaterialPageRoute(builder: (context)=> BookFilterScreen());

      case Routes.favoritesScreen:
        return MaterialPageRoute(builder: (context)=> FavoritesScreen());
    }
    return null;
  };
}
