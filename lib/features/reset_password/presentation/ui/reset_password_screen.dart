// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/special_form_field.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/reset_password/presentation/manager/cubit/reset_password_cubit.dart';
import 'package:book_store/features/splash_screen/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String code;
  const ResetPasswordScreen({super.key, required this.code});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var passwordController = TextEditingController();
  var confPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confPasswordController.dispose();
    super.dispose();
  }

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
        title: TitleText(title: "Reset password"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 14, right: 16, bottom: 14, left: 16),
        child: SingleChildScrollView(
          child: BlocListener<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              if (state is ResetPasswordLoading) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: AppColors.transparenteColor,
                          content: Center(child: CircularProgressIndicator()),
                        ));
              } else if (state is ResetPasswordError) {
                Navigator.pop(context); // to close the dialog
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(state.errorMsg),
                        ));
              } else if (state is ResetPasswordSuccess) {
                Navigator.pushNamed(context, Routes.splashScreen);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      LabelText(
                        text: 'Your new password must be',
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      LabelText(
                        text: 'different from previous one',
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                LabelText(
                  text: "Password",
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8.h),
                SpecialFormField(
                  hint: "**********",
                  obscureText: true,
                  controller: passwordController,
                ),
                SizedBox(height: 32.h),
                LabelText(
                  text: "Confirm password",
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8.h),
                SpecialFormField(
                  hint: "**********",
                  obscureText: true,
                  controller: confPasswordController,
                ),
                SizedBox(height: 32.h),
                button(
                  backgroundColor: AppColors.pinkColor,
                  foregroundColor: AppColors.whiteColor,
                  buttonText: 'Reset password',
                  onPressed: () {
                    
                    context.read<ResetPasswordCubit>().resetPassword(
                      code: widget.code,
                      password: passwordController.text,
                      confPassword: confPasswordController.text
                      );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
