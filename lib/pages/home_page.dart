import 'package:carros/api/carros/carros_api.dart';
import 'package:carros/widgets/drawer_list.dart';
import 'package:carros/widgets/carros/carros_listview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Carros Home Page"),
          centerTitle: true,
          bottom: TabBar(tabs: [
            Tab(text: "Clássicos",),
            Tab(text: "Esportivos",),
            Tab(text: "Luxo",),
          ],),
        ),
        drawer: DrawerList(),
        body: TabBarView(children: [
          CarrosListView(tipo: describeEnum(TipoCarro.classicos),),
          CarrosListView(tipo: describeEnum(TipoCarro.esportivos),),
          CarrosListView(tipo: describeEnum(TipoCarro.luxo),),
        ]),
      ),
    );
  }
}
