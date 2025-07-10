// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/profile/presentation/ui/widgets/list_tile_widgte.dart';
import 'package:book_store/features/profile/presentation/ui/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  // Load the saved image from SharedPreferences
  Future<void> _loadImage() async {
    final imagePath = await SharedPrefsHelper.getImagePath();
    if (imagePath != null && await File(imagePath).exists()) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> _pickImage() async {
    showDialog(
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
                leading: Icon(Icons.camera_alt),
                title: LabelText(
                    text: 'Camera', size: 15, fontWeight: FontWeight.w500),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                    await SharedPrefsHelper.saveImagePath(pickedFile.path);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: LabelText(
                    text: 'Gallery', size: 15, fontWeight: FontWeight.w500),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                    await SharedPrefsHelper.saveImagePath(pickedFile.path);
                  }
                },
              ),
            ],
          ),
        );
      },
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
              onTap: () {},
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
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
