// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:bloc/bloc.dart';
import 'package:book_store/features/code_verification/data/repo/code_verfication_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'code_verification_state.dart';

class CodeVerificationCubit extends Cubit<CodeVerificationState> {
  CodeVerificationCubit() : super(CodeVerificationInitial());

  void codeVerification({
    required String email,
    required String code,
  }) async {
    emit(CodeVerificationLoading());
    final response = await CodeVerficationRepo.codeVerification(
      email: email,
      code: code,
    );

    if (response is Response) {
      if (response.statusCode == 200) {
        emit(CodeVerificationSuccess());
      } else if (response.statusCode == 422) {
        final data = response.data as Map<String, dynamic>;
        String errorMsg = data['message'] as String;
        emit(CodeVerificationError(errorMsg));
      } else {
        emit(CodeVerificationError('A server error occurred, please try again later.'));
      }
    } else {
      emit(CodeVerificationError('An unexpected error occurred, please try again later.'));
    }
  }
}