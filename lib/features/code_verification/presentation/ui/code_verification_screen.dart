// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'dart:developer';

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/code_verification/presentation/manager/cubit/code_verification_cubit.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/special_text_button.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/splash_screen/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeVerificationScreen extends StatefulWidget {
  final String email;
  
  const CodeVerificationScreen({super.key, required this.email});

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String _getVerificationCode() {
    return _controllers.map((controller) => controller.text).join();
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
        title: TitleText(title: "Enter code"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 14, right: 16, bottom: 14, left: 16),
        child: SingleChildScrollView(
          child: BlocListener<CodeVerificationCubit, CodeVerificationState>(
            listener: (context, state) {
              if (state is CodeVerificationLoading) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: AppColors.transparenteColor,
                          content: Center(child: CircularProgressIndicator()),
                        ));
              } else if (state is CodeVerificationError) {
                Navigator.pop(context); // to close the dialog
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Text(state.errorMsg),
                        ));
              } else if (state is CodeVerificationSuccess) {
                Navigator.pushNamed(context, Routes.resetPasswordScreen , arguments: _getVerificationCode());
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
                        text: 'Enter the 4 digits code that',
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      LabelText(
                        text: 'you received on your email',
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: TextField(
                          controller: _controllers[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(width: 1.0),
                            ),
                            contentPadding: EdgeInsets.all(0),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                button(
                  backgroundColor: AppColors.pinkColor,
                  foregroundColor: AppColors.whiteColor,
                  buttonText: 'Reset password',
                  onPressed: () {
                    log(widget.email);
                    log(_getVerificationCode());
                      context.read<CodeVerificationCubit>().codeVerification(
                            email: widget.email,
                            code: _getVerificationCode(),
                          );
                   
                  },
                ),
                SizedBox(height: 80),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LabelText(
                        text: "Didn’t receive a code?",
                        size: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      SpecialTextButton(
                        text: "Send again",
                        size: 14,
                        color: AppColors.pinkColor,
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.forgetPasswordScreen);
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