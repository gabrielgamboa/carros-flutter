import 'package:carros/api/carros/carros_api.dart';
import 'package:carros/drawer_list.dart';
import 'package:carros/models/carro.dart';
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
    List<Carro> carros = CarrosApi.getCarros();

    return ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          Carro carro = carros[index];

          return Row(
            children: [
              Image.network(carro.urlFoto!, width: 150,),
              Flexible(
                  child: Text(
                    carro.nome!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 21),
              ))
            ],
          );
        });
  }
}
