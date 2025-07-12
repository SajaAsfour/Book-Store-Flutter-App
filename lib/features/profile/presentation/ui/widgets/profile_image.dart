// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required File? image,
  }) : _image = image;

  final File? _image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: _image != null
              ? FileImage(_image)
              : AssetImage('assets/images/profile_image.png') as ImageProvider,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.pinkColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt,
              color: AppColors.whiteColor,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}