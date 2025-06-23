// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import 'package:book_store/features/login/presentation/ui/widgets/special_form_field.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/splash_screen/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
        title: TitleText(title: "Forget password"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 14, right: 16, bottom: 14, left: 16),
        child: SingleChildScrollView(
          child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordLoading) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: AppColors.transparenteColor,
                          content: Center(child: CircularProgressIndicator()),
                        ));
              } else if (state is ForgetPasswordError) {
                Navigator.pop(context); // to close the dialog
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(state.errorMsg),
                        ));
              } else if (state is ForgetPasswordSuccess) {
                Navigator.pushNamed(context, Routes.codeScreen , arguments: emailController.text);
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
                        text: 'Enter your email',
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      LabelText(
                        text: 'to reset your password',
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                LabelText(
                  text: 'Email',
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8),
                SpecialFormField(
                  controller: emailController,
                  hint: "Example@gmail.com",
                  obscureText: false,
                ),
                SizedBox(height: 16),
                button(
                  backgroundColor: AppColors.pinkColor,
                  foregroundColor: AppColors.whiteColor,
                  buttonText: 'Send Code',
                  onPressed: () {
                    
                    context.read<ForgetPasswordCubit>().forgetPassword(
                          email: emailController.text,
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
