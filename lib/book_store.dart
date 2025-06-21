// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/app_routes/app_router.dart';
import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookStore extends StatelessWidget {
  const BookStore({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: _startRoute(),
        onGenerateRoute: AppRouter.onGenerateRoute
      ),
    );
  }

  _startRoute (){
    if (SharedPrefsHelper.getData(key: SharedPrefsKeys.userToken)!= null){
      return Routes.homeScreen;
    }else{
      return Routes.splashScreen;
    }
  }
}
