import 'package:book_store/book_store.dart';
import 'package:book_store/core/services/networking/dio_factory.dart';
import 'package:flutter/material.dart';

void main() {
  DioFactory.init();
  runApp(const BookStore());
}

