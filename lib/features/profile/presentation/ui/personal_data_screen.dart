// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:book_store/core/services/local/shared_prefs_helper.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/profile/presentation/ui/widgets/editable_form_field.dart';
import 'package:book_store/features/profile/presentation/ui/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => _PersonalDataScreenState();
}

class _PersonalDataScreenState extends State<PersonalDataScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isEditing = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _currentUserEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _nameController.text =
        await SharedPrefsHelper.getData(key: 'user_name') ?? '';
    _emailController.text =
        await SharedPrefsHelper.getData(key: 'user_email') ?? '';
    _phoneController.text =
        await SharedPrefsHelper.getData(key: 'user_phone') ?? '';
    _addressController.text =
        await SharedPrefsHelper.getData(key: 'user_address') ?? '';

    _currentUserEmail = await SharedPrefsHelper.getData(key: 'user_email');
    final imagePath = await SharedPrefsHelper.getData(key: 'user_image_$_currentUserEmail');
    if (imagePath != null && await File(imagePath).exists()) {
     
    setState(() {_image = File(imagePath);});}
  }

  Future<void> _saveUserData() async {
    if (_isEditing) {
      await SharedPrefsHelper.saveData(
          key: 'user_name', value: _nameController.text);
      await SharedPrefsHelper.saveData(
          key: 'user_email', value: _emailController.text);
      await SharedPrefsHelper.saveData(
          key: 'user_phone', value: _phoneController.text);
      await SharedPrefsHelper.saveData(
          key: 'user_address', value: _addressController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully!')),
      );
    }
    setState(() {
      _isEditing = !_isEditing;
    });
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
                    await SharedPrefsHelper.saveData(key: 'user_image_$_currentUserEmail', value: pickedFile.path);
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
                    await SharedPrefsHelper.saveData(key: 'user_image_$_currentUserEmail', value: pickedFile.path);
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              GestureDetector(
                onTap: _saveUserData,
                child: Row(
                  children: [
                    SizedBox(
                      height: 14,
                      width: 14,
                      child: Image.asset('assets/images/editIcon.png'),
                    ),
                    SizedBox(width: 5,),
                    LabelText(text: "Edit", size: 14, fontWeight: FontWeight.w600,color: AppColors.pinkColor,)
                  ],
                ),
              ),
              SizedBox(height: 30,),
              Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: ProfileImage(image: _image),
              ),
            ),
            SizedBox(height: 10,),
              EditableFormField(
                controller: _nameController,
                label: 'Name',
                enabled: _isEditing,
              ),
              EditableFormField(
                controller: _emailController,
                label: 'Email',
                enabled: _isEditing,
              ),
              EditableFormField(
                controller: _phoneController,
                label: 'Phone number',
                enabled: _isEditing,
              ),
              EditableFormField(
                controller: _addressController,
                label: 'Address',
                enabled: _isEditing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
