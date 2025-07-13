// ignore_for_file: prefer_const_constructors

import 'package:book_store/core/app_routes/routes.dart';
import 'package:book_store/core/utils/app_colors.dart';
import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/splash_screen/presentation/ui/widgets/button.dart';
import 'package:flutter/material.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String? _selectedPaymentMethod;
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 16),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: TitleText(title: "Check Out"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelText(text:
             'Payment Method', 
             size: 14, fontWeight: FontWeight.w600),
           
            SizedBox(height: 16),
            RadioListTile(
              title: LabelText(text: 'Online payment', size: 14, fontWeight: FontWeight.w400,),
              value: 'online',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value as String?;
                });
              },
            ),
            RadioListTile(
              title: LabelText(text: 'Cash on delivery', size: 14, fontWeight: FontWeight.w400,),
              value: 'cash',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value as String?;
                });
              },
            ),
            RadioListTile(
              title: LabelText(text: 'POS on delivery', size: 14, fontWeight: FontWeight.w400,),
              value: 'pos',
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value as String?;
                });
              },
            ),
            SizedBox(height: 16),
            LabelText(text:
             'Add Note', 
             size: 14, fontWeight: FontWeight.w600),
            
            SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                hintText: 'Add note',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note_add),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            button(backgroundColor: AppColors.pinkColor, 
            foregroundColor: AppColors.whiteColor, 
            buttonText: 'Confirm order', onPressed: (){
              Navigator.pushNamed(context, Routes.confirmOrderScreen);
            }),
            
          ],
        ),
      ),
    );
  }
}