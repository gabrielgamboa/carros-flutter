import 'package:carros/api/carros/carros_api.dart';
import 'package:carros/utils/prefs.dart';
import 'package:carros/widgets/drawer_list.dart';
import 'package:carros/widgets/carros/carros_listview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  late TabController _tabController;
  bool _gridView = false;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {

    // Primeiro busca o índice nas prefs.
    int tabIdx = await Prefs.getInt("tabIdx");

    // Depois cria o TabController
    // No método build na primeira vez ele poderá estar nulo
    _tabController = TabController(length: 3, vsync: this);

    // Agora que temos o TabController e o índice da tab,
    // chama o setState para redesenhar a tela
    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: () {
            setState(() {
              _gridView = false;
            });
          }),
          IconButton(icon: Icon(Icons.grid_on),onPressed: () {
            setState(() {
              _gridView = true;
            });
          }),
        ],
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: "Clássicos",
                  ),
                  Tab(
                    text: "Esportivos",
                  ),
                  Tab(
                    text: "Luxo",
                  )
                ],
              ),
      ),
      body: _tabController == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                CarrosListView(tipo: describeEnum(TipoCarro.classicos), gridView: _gridView,),
                CarrosListView(tipo: describeEnum(TipoCarro.esportivos), gridView: _gridView),
                CarrosListView(tipo: describeEnum(TipoCarro.luxo), gridView: _gridView),
              ],
            ),
      drawer: DrawerList(),
    );
  }
}
