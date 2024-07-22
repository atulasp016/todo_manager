import 'package:flutter/material.dart';
import 'package:todo_manager/domain/utils/app_style.dart';

class OutlineBtn extends StatelessWidget {
  VoidCallback? onPressed;
  String title;
  double mWidth;

  OutlineBtn({
    super.key,
    required this.onPressed,
    required this.title,
    this.mWidth = 140,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mWidth,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(width: 1, color: Colors.blue)),
        child: Text(title, style: mTextStyle16()),
      ),
    );
  }
}
