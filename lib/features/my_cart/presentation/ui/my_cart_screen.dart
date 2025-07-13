// ignore_for_file: prefer_const_constructors

import 'package:book_store/features/login/presentation/ui/widgets/title_text.dart';
import 'package:book_store/features/my_cart/presentation/manager/cubit/cart_cubit.dart';
import 'package:book_store/features/my_cart/presentation/ui/widgets/my_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().fetchCart();
  }

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
        title: TitleText(title: "My Cart"),
      ),
      body: MyCartWidget(),
    );
  }
}
