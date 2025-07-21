import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/features/favorites/presentation/manager/cubit/favorites_cubit.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/profile/presentation/ui/widgets/list_tile_widgte.dart';
import 'package:book_store/features/profile/presentation/ui/widgets/profile_image.dart';
import 'package:book_store/features/profile/data/repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:book_store/core/app_routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore_for_file: prefer_const_constructors

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  String? _currentUserEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _currentUserEmail = await SharedPrefsHelper.getData(key: 'user_email');
    final loadedImage = await ProfileRepo.loadUserImage(_currentUserEmail);
    if (loadedImage != null) {
      setState(() {
        _image = loadedImage;
      });
    }
  }

  Future<void> _pickImage() async {
    File? pickedImage;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: LabelText(
              text: 'Select Image Source',
              size: 20,
              fontWeight: FontWeight.w500),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: LabelText(
                    text: 'Camera', size: 15, fontWeight: FontWeight.w500),
                onTap: () async {
                  Navigator.of(context).pop();
                  pickedImage = await ProfileRepo.pickImage(_currentUserEmail);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: LabelText(
                    text: 'Gallery', size: 15, fontWeight: FontWeight.w500),
                onTap: () async {
                  Navigator.of(context).pop();
                  pickedImage = await ProfileRepo.pickImage(_currentUserEmail);
                },
              ),
            ],
          ),
        );
      },
    );
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  Future<void> _logout() async {
    await SharedPrefsHelper.removeData(key: SharedPrefsKeys.userToken);
    await SharedPrefsHelper.removeData(key: 'user_name');
    await SharedPrefsHelper.removeData(key: 'user_email');
    // Notify FavoritesCubit of user change
    await context.read<FavoritesCubit>().onUserChanged();
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.loginScreen,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: ProfileImage(image: _image),
              ),
            ),
            SizedBox(height: 30),
            ListTileWidgte(
              imagePath: 'assets/images/profileIcon.png',
              labelText: 'Personal data',
              onTap: () {
                Navigator.pushNamed(context, Routes.personalDataScreen);
              },
            ),
            ListTileWidgte(
              imagePath: 'assets/images/orderHistoryIcon.png',
              labelText: 'Order History',
              onTap: () {},
            ),
            ListTileWidgte(
              imagePath: 'assets/images/addressIcon.png',
              labelText: 'Address',
              onTap: () {},
            ),
            ListTileWidgte(
              imagePath: 'assets/images/helpIcon.png',
              labelText: 'Help',
              onTap: () {},
            ),
            ListTileWidgte(
              imagePath: 'assets/images/logoutIcon.png',
              labelText: 'Log Out',
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}