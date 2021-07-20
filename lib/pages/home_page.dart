import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Text("Gamboa", style: TextStyle(fontSize: 18),),
    );
  }
}