import 'package:carros/api/carros/carros_api.dart';
import 'package:carros/models/carro.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CarrosListView extends StatelessWidget {
  String tipo;
  
  CarrosListView({required this.tipo});


  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    Future<List<Carro>> futureCarros = CarrosApi.getCarros(tipo);

    //FutureBuilder é utilizado para renderizar Widgets com base em resolução de uma Future
    return FutureBuilder(
        future:
            futureCarros, //future utilizada no FutureBuilder, executa no início da resolução e no fim da resolução
        builder: (context, snapshot) {
          //snapshot seria uma "captura" da future no momento em que está sendo executado
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                "Não foi possível buscar os carros",
                style: TextStyle(color: Colors.red, fontSize: 22),
              ),
            );
          }
          //até a future não ser resolvida, é mostrado o CircularProgressIndicator
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Carro> carros = snapshot.data as List<Carro>;
          return _listView(carros, context);
        });
  }

  Container _listView(List<Carro> carros, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ScrollConfiguration(
        //widget para configurar o scroll dos filhos
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
            itemCount: carros.length,
            itemBuilder: (context, index) {
              Carro carro = carros[index];

              return Card(
                color: Colors.grey[100],
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Image.network(
                        carro.urlFoto!,
                        width: 250,
                      )),
                      Text(
                        carro.nome!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        "descrição",
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton(
                          child: const Text('BUY TICKETS'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('LISTEN'),
                          onPressed: () {/* ... */},
                        ),
                        const SizedBox(width: 8),
                      ]),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
