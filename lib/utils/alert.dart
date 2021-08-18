import 'package:flutter/material.dart';

alert(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Aplicativo de Carros"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Ok")),
            ],
          ),
        );
      });
}
