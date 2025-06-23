// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/splash_screen/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 22,
            width: 22,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        leadingWidth: 30,
        title: TitleText(title: " "),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 14, right: 16, bottom: 14, left: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                        'assets/images/changePas.png',
                        height: 103,
                        width: 103,
                      ),
                    SizedBox(height: 20),
                    LabelText(text: "Password Changed!", size: 22, fontWeight: FontWeight.w600),
                    LabelText(
                      text: 'Your password has been',
                      size: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                     LabelText(
                      text: 'changed successfully',
                      size: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 38),
              button(
                backgroundColor: AppColors.pinkColor,
                foregroundColor: AppColors.whiteColor,
                buttonText: 'Finish!',
                onPressed: () {
                  
                  Navigator.pushNamed(context, Routes.homeScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
