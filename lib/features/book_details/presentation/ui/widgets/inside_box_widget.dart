// ignore_for_file: prefer_const_constructors

import 'package:book_store/features/login/presentation/ui/widgets/label_text.dart';
import 'package:flutter/material.dart';

class InsideBoxWidget extends StatelessWidget {
  final Color color;
  final String text;
  final IconData? iconData;
  const InsideBoxWidget({
    super.key, required this.color, required this.text, this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData,
              color:color, size: 12),
          SizedBox(width: 8.0),
          LabelText(
            text: text,
            size: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ],
      );
  }
}
