// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/features/create_account/data/repo/create_account_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountInitial());

  void createAccount({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(CreateAccountLoading());
    final response = await CreateAccountRepo.createAccount(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    if (response is Response) {
      if (response.statusCode == 201) {
        SharedPrefsHelper.saveData(
          key: SharedPrefsKeys.userToken,
          value: response.data['data']['token'],
        );
        emit(CreateAccountSuccess());
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

        emit(CreateAccountError(errorMsg));
      } else {
        emit(CreateAccountError('A server error occurred, please try again later.'));
      }
    } else {
      emit(CreateAccountError('An unexpected error occurred, please try again later.'));
    }
  }
}
