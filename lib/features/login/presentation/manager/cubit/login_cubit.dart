// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/core/services/networking/dio_factory.dart';
import 'package:book_store/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:book_store/features/login/data/repo/login_repo.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoading());
    final response = await LoginRepo.login(
      email: email,
      password: password,
    );

    if (response is Response) {
      if (response.statusCode == 200) {
        await SharedPrefsHelper.init();
        await SharedPrefsHelper.saveData(
          key: SharedPrefsKeys.userToken,
          value: response.data['data']['token'],
        );
        await DioFactory.setTokenFromStorage();
        final storedName = await SharedPrefsHelper.getData(key: 'user_name') ?? '';
        if (storedName.isEmpty) {
          await SharedPrefsHelper.saveData(key: 'user_name', value: '');
        }
        await SharedPrefsHelper.saveData(key: 'user_email', value: email);
        await context.read<FavoritesCubit>().onUserChanged();
        emit(LoginSuccess());
      } else if (response.statusCode == 422) {
        String errorMsg = response.data['message'];
        if (response.data['errors'] != null && response.data['errors'] is Map) {
          log("message");
          List<String> errorDetails = [];
          response.data['errors'].forEach((key, value) {
            if (value is List) {
              errorDetails.addAll(value.map((e) => e.toString()));
            }
          });

          if (errorDetails.isNotEmpty) {
            errorMsg += '\n' + errorDetails.join('\n');
          }
        }

        emit(LoginError(errorMsg));
      } else {
        emit(LoginError('A server error occurred, please try again later.'));
      }
    } else {
      emit(LoginError('An unexpected error occurred, please try again later.'));
    }
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
    emit(LoginLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(LoginError('Google Sign-In cancelled'));
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      await SharedPrefsHelper.init();
      await SharedPrefsHelper.saveData(key: 'user_name', value: userCredential.user?.displayName ?? '');
      await SharedPrefsHelper.saveData(key: 'user_email', value: userCredential.user?.email ?? '');
      await context.read<FavoritesCubit>().onUserChanged();
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> signInWithFacebook({required BuildContext context}) async {
    emit(LoginLoading());
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        await SharedPrefsHelper.init();
        await SharedPrefsHelper.saveData(key: 'user_name', value: userCredential.user?.displayName ?? '');
        await SharedPrefsHelper.saveData(key: 'user_email', value: userCredential.user?.email ?? '');
        await context.read<FavoritesCubit>().onUserChanged();
        emit(LoginSuccess());
      } else {
        emit(LoginError('Facebook Sign-In failed'));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}