import 'package:carros/api/carros/carros_api.dart';
import 'package:carros/models/carro.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  final String tipo;
  bool gridView = false;

  CarrosListView({required this.tipo, this.gridView = false});

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

//mixin sao usados com a palavra "with" e servem pra dar especificacoes pra alguma determinada classe
class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  @override
  // SingleTickerProviderStateMixin no widget da home page
  // AutomaticKeepAliveClientMixin no widget que você quer manter o estado sem carregar novamente
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    Future<List<Carro>> futureCarros = CarrosApi.getCarros(widget.tipo);

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
      
        child: widget.gridView == false ? ListView.builder(
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
            }) : GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: carros.length,
            itemBuilder: (context, index) {
              {
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
            }
            }),
      ),
    );
  }
}
