// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/create_account/presentation/manager/cubit/create_account_cubit.dart';
import 'package:book_store/features/login/presentation/ui/widgets/special_form_field.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/special_outlined_button.dart';
import 'package:book_store/features/login/presentation/ui/widgets/special_text_button.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/splash_screen/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool agreeWith = false;
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmationPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmationPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            height: 22.h,
            width: 22.w,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        leadingWidth: 30,
        title: TitleText(title: "Create account"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 14, right: 16, bottom: 14, left: 16),
        child: SingleChildScrollView(
          child: BlocListener<CreateAccountCubit, CreateAccountState>(
            listener: (context, state) {
              if (state is CreateAccountLoading) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: AppColors.transparenteColor,
                          content: Center(child: CircularProgressIndicator()),
                        ));
              } else if (state is CreateAccountError) {
                Navigator.pop(context); // to close the dialog
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(state.errorMsg),
                        ));
              } else if (state is CreateAccountSuccess) {
                Navigator.pushNamed(context, Routes.homeScreen);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelText(
                  text: 'Name',
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8.h),
                SpecialFormField(
                  hint: "John Smith",
                  obscureText: false,
                  controller: nameController,
                ),
                SizedBox(height: 16.h),
                LabelText(
                  text: 'Email',
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8.h),
                SpecialFormField(
                  hint: "Example@gmail.com",
                  obscureText: false,
                  controller: emailController,
                ),
                SizedBox(height: 16.h),
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
                SizedBox(height: 16.h),
                LabelText(
                  text: "Confirm password",
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8.h),
                SpecialFormField(
                  hint: "**********",
                  obscureText: true,
                  controller: confirmationPasswordController,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Checkbox(
                      value: agreeWith,
                      onChanged: (value) {
                        setState(() {
                          agreeWith = value!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return AppColors.pinkColor;
                          }
                          return AppColors.whiteColor;
                        },
                      ),
                    ),
                    LabelText(
                      text: " Agree with",
                      size: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    SpecialTextButton(
                      text: 'Terms & Conditions',
                      size: 14,
                      color: AppColors.pinkColor,
                      fontWeight: FontWeight.w400,
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                button(
                  backgroundColor: AppColors.pinkColor,
                  foregroundColor: AppColors.whiteColor,
                  buttonText: 'Create account',
                  onPressed: () {
                    context.read<CreateAccountCubit>().createAccount(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          passwordConfirmation:
                              confirmationPasswordController.text,
                        );
                  },
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: LabelText(
                        text: "Or sign in with",
                        size: 12,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    SpecialOutlinedButton(
                      imageUrl: 'assets/images/facebook_icon.png',
                      text: 'Facebook',
                      onPressed: () {
                        context.read<CreateAccountCubit>().signInWithFacebook();
                      },
                    ),
                    SizedBox(width: 16.h),
                    SpecialOutlinedButton(
                      imageUrl: 'assets/images/google_icon.png',
                      text: 'Google',
                      onPressed: () {
                        context.read<CreateAccountCubit>().signInWithGoogle();
                      },
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LabelText(
                        text: "Already have an account?",
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      SpecialTextButton(
                        text: "Login",
                        size: 14,
                        color: AppColors.pinkColor,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.loginScreen);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}