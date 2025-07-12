import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileRepo {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> loadUserImage(String? userEmail) async {
    if (userEmail == null) return null;
    final imagePath = await SharedPrefsHelper.getData(key: 'user_image_$userEmail');
    if (imagePath != null && await File(imagePath).exists()) {
      return File(imagePath);
    }
    return null;
  }

  static Future<File?> pickImage(String? userEmail) async {
    if (userEmail == null) return null;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Default to gallery, can be extended
    if (pickedFile != null) {
      await SharedPrefsHelper.saveData(key: 'user_image_$userEmail', value: pickedFile.path);
      return File(pickedFile.path);
    }
    return null;
  }
}