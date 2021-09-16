import 'package:carros/models/carro.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatelessWidget {
  late final Carro carro;
  
  CarroPage({required this.carro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome!),
      ),
      body: _body(context),
    );
  }

  Widget _body(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(carro.urlFoto!),
        ],
      )
    );
  }
}