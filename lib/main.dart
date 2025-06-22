import 'package:book_store/book_store.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/core/services/networking/dio_factory.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefsHelper.init();
  DioFactory.init();
  runApp(const BookStore());
}
