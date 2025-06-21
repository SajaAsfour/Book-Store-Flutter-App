import 'package:bloc/bloc.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/features/create_account/data/repo/create_account_repo.dart';
import 'package:dio/dio.dart';
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
      if(response.statusCode  == 201){
        SharedPrefsHelper.saveData(key: SharedPrefsKeys.userToken, 
        value: response.data['data']['token'],);
        emit(CreateAccountSuccess());
      }else{
        emit(CreateAccountError(response.data['message']));
      }
    } else {
      emit(CreateAccountError("error"));
    }
  }
}
