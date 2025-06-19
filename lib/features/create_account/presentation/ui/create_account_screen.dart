// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/app_routes/routes.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, Routes.loginScreen );
            }, child: Text("Login"))
          ],
        ),
      ),
    );
  }
}