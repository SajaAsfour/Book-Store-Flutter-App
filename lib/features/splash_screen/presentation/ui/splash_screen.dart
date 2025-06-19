// ignore_for_file: use_super_parameters

import 'dart:async';
import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/splash_screen/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showContent = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        showContent = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            showContent
                ? 'assets/images/library_bg_2.png'
                : 'assets/images/library_bg.png',
            fit: BoxFit.cover,
          ),

          if (showContent)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_white.png',
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Bookshop',
                        style: TextStyle(
                          fontFamily: "Open Sans",
                          fontSize: 30,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  button(backgroundColor: AppColors.pinkColor, foregroundColor: AppColors.whiteColor, buttonText: 'Log in', routeName: Routes.loginScreen,),
                  const SizedBox(height: 12),
                  button(backgroundColor: AppColors.whiteColor, foregroundColor: AppColors.pinkColor, buttonText: "Create account", routeName: Routes.createAccountScreen),
                  const SizedBox(height: 40),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
