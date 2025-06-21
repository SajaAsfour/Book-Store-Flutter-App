import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: (){
              SharedPrefsHelper.removeData(key: SharedPrefsKeys.userToken);
              Navigator.pushNamedAndRemoveUntil(context, Routes.createAccountScreen, (r)=>false);
            }, child: Text("LogOut"))
          ],
        ),
      ),
    );
  }
}