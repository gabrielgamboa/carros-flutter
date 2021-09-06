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
  late TabController _tabBarController;

  //construtor de um statefull Widget, é chamado apenas uma vez quando o componente é renderizado
  //ou seja, não é executado novamente quando o setState é chamado
  @override
  void initState() {
    super.initState();
    _initTabBars(); //inicializar controller da tabBar via método pra poder utilizar async/await e retirar o uso do then
  }

  Future<void> _initTabBars() async {
    _tabBarController = TabController(
        length: 3,
        vsync: this /*passando o mixin do widget via palavra "this"*/);

    int futureGetInt = await Prefs.getInt("tabIndex");
    _tabBarController.index = futureGetInt;

    _tabBarController.addListener(() {
      Prefs.setInt("tabIndex", _tabBarController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Carros Home Page"),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabBarController,
            tabs: [
              Tab(
                text: "Clássicos",
              ),
              Tab(
                text: "Esportivos",
              ),
              Tab(
                text: "Luxo",
              ),
            ],
          ),
        ),
        drawer: DrawerList(),
        body: TabBarView(controller: _tabBarController, children: [
          CarrosListView(
            tipo: describeEnum(TipoCarro.classicos),
          ),
          CarrosListView(
            tipo: describeEnum(TipoCarro.esportivos),
          ),
          CarrosListView(
            tipo: describeEnum(TipoCarro.luxo),
          ),
        ]),
      ),
    );
  }

  
}
