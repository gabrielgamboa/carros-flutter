import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String? text;
  VoidCallback? onPressed;

  AppButton(this.text, {required this.onPressed});

  @override
  Widget build(BuildContext context) {
     return Container(
      height: 46,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        ),
        onPressed: onPressed,
        child: Text(
          text!,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}