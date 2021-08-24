import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;

  bool showProgress;

  AppButton(this.text, {required this.onPressed, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        ),
        onPressed: onPressed,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text!,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
      ),
    );
  }
}
