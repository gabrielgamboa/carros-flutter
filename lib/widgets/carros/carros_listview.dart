import 'package:carros/api/carros/carros_api.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
  List<Carro>? carros;

  @override
  // SingleTickerProviderStateMixin no widget da home page
  // AutomaticKeepAliveClientMixin no widget que você quer manter o estado sem carregar novamente
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadListView();
  }

  _loadListView() async {
    List<Carro> listaCarros = await CarrosApi.getCarros(widget.tipo);

    setState(() {
      this.carros = listaCarros;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (carros == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return _listView(carros, context);
  }

  Container _listView(List<Carro>? carros, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ScrollConfiguration(
        //widget para configurar o scroll dos filhos
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),

        child: widget.gridView == false
            ? ListView.builder(
                itemCount: carros!.length,
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: const Text('Detalhes'),
                                  onPressed: () => _onClickCarro(carro),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('Share'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                              ]),
                        ],
                      ),
                    ),
                  );
                })
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: carros!.length,
                itemBuilder: (context, index) {
                  {
                    Carro carro = carros[index];

                    return Card(
                      color: Colors.grey[100],
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Expanded(
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
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "descrição",
                                style: TextStyle(fontSize: 16),
                              ),
                              Expanded(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TextButton(
                                        child: const Text(
                                          'BUY TICKETS',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        onPressed: () {/* ... */},
                                      ),
                                      TextButton(
                                        child: const Text('LISTEN',
                                            style: TextStyle(fontSize: 12)),
                                        onPressed: () {/* ... */},
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
      ),
    );
  }

  _onClickCarro(Carro carro) {
    push(context, CarroPage(carro: carro));
  }
}
