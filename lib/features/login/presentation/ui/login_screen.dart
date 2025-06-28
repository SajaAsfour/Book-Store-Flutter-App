// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/manager/cubit/login_cubit.dart';
import 'package:book_store/features/login/presentation/ui/widgets/special_form_field.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/special_outlined_button.dart';
import 'package:book_store/features/login/presentation/ui/widgets/special_text_button.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/splash_screen/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSavedLoginData();
  }

  void loadSavedLoginData() async {
    final savedEmail = SharedPrefsHelper.getData(key: 'saved_email');
    final savedPassword = SharedPrefsHelper.getData(key: 'saved_password');
    final savedRememberMe = SharedPrefsHelper.getData(key: 'remember_me');

    if (savedEmail != null &&
        savedPassword != null &&
        savedRememberMe == true) {
      setState(() {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        rememberMe = true;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
        title: TitleText(title: "Log in"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 14, right: 16, bottom: 14, left: 16),
        child: SingleChildScrollView(
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: AppColors.transparenteColor,
                          content: Center(child: CircularProgressIndicator()),
                        ));
              } else if (state is LoginError) {
                Navigator.pop(context); // to close the dialog
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(state.errorMsg),
                        ));
              } else if (state is LoginSuccess) {
                Navigator.pushNamed(context, Routes.bottomNavBarScreen);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                LabelText(
                  text: "Password",
                  size: 16,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: 8),
                SpecialFormField(
                  controller: passwordController,
                  hint: "**********",
                  obscureText: true,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value!;
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
                      text: "Remember me",
                      size: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    Spacer(),
                    SpecialTextButton(
                      text: 'Forget your password?',
                      size: 14,
                      color: AppColors.pinkColor,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.forgetPasswordScreen);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                button(
                  backgroundColor: AppColors.pinkColor,
                  foregroundColor: AppColors.whiteColor,
                  buttonText: 'Log in',
                  onPressed: () async {
                    // Save login data if remember me is checked
                    if (rememberMe) {
                      await SharedPrefsHelper.saveData(
                          key: 'saved_email', value: emailController.text);
                      await SharedPrefsHelper.saveData(
                          key: 'saved_password', value: passwordController.text);
                      await SharedPrefsHelper.saveData(
                          key: 'remember_me', value: true);
                    } else {
                      await SharedPrefsHelper.removeData(key: 'saved_email');
                      await SharedPrefsHelper.removeData(key: 'saved_password');
                      await SharedPrefsHelper.saveData(
                          key: 'remember_me', value: false);
                    }

                    context.read<LoginCubit>().login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  },
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: LabelText(
                        text: "Or login with",
                        size: 12,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    SpecialOutlinedButton(
                      imageUrl: 'assets/images/facebook_icon.png',
                      text: 'Facebook',
                      onPressed: () {
                        context.read<LoginCubit>().signInWithFacebook();
                      },
                    ),
                    SizedBox(width: 16),
                    SpecialOutlinedButton(
                      imageUrl: 'assets/images/google_icon.png',
                      text: 'Google',
                      onPressed: () {
                        context.read<LoginCubit>().signInWithGoogle();
                      },
                    )
                  ],
                ),
                SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LabelText(
                        text: "Don’t have an account? ",
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      SpecialTextButton(
                        text: "Sign up",
                        size: 14,
                        color: AppColors.pinkColor,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.createAccountScreen);
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
