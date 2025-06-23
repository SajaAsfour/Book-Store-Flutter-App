import 'package:book_store/book_store.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/core/services/networking/dio_factory.dart';
import 'package:book_store/features/create_account/presentation/manager/cubit/create_account_cubit.dart';
import 'package:book_store/features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import 'package:book_store/features/login/presentation/manager/cubit/login_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefsHelper.init();
  DioFactory.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<CreateAccountCubit>(
          create: (context) => CreateAccountCubit(),
        ),
         BlocProvider<ForgetPasswordCubit>(
          create: (context) => ForgetPasswordCubit(),
        ),
      ],
      child: const BookStore(),
    ),
  );
}