// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/bottom_nav_bar/presentation/ui/widgets/bottom_nav_bar_icon.dart';
import 'package:book_store/features/home/presentation/ui/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 48,
        width: 48,
        child: FloatingActionButton(
          backgroundColor: AppColors.whiteColor,
          onPressed: () {
            _currentIndex = 2;
            setState(() {});
          },
          shape: CircleBorder(),
          child: Icon(
            Icons.search,
            size: 20,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.whiteColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavBarIcon(
              isActive: _currentIndex == 0,
              onTap: () {
                _currentIndex = 0;
                setState(() {});
              },
              icon: Icons.home_rounded,
              iconText: 'Home',
            ),
            BottomNavBarIcon(
              isActive: _currentIndex == 1,
              onTap: () {
                _currentIndex = 1;
                setState(() {});
              },
              icon: Icons.book_outlined,
              iconText: 'Books',
            ),
            SizedBox(),
            BottomNavBarIcon(
              isActive: _currentIndex == 3,
              onTap: () {
                _currentIndex = 3;
                setState(() {});
              },
              iconText: 'My Cart',
              icon: Icons.shopping_cart,
            ),
            BottomNavBarIcon(
              isActive: _currentIndex == 4,
              onTap: () {
                _currentIndex = 4;
                setState(() {});
              },
              icon: Icons.person_pin,
              iconText: 'Profile',
            ),
            
          ],
        ),
      ),
      body: _getBody(),
    );
  }
  Widget _getBody() {
  switch (_currentIndex) {
    case 0:
      return HomeScreen();
    // other Screen
    default:
      return Center(child: Text('Page not found'));
  }
}

}