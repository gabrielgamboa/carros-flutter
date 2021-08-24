import 'package:carros/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
      ),
      drawer: DrawerList(),
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Text("Gamboa", style: TextStyle(fontSize: 18),),
    );
  }
}