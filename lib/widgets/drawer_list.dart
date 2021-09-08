import 'package:carros/models/usuario.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Usuario?> userFuture = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            FutureBuilder(
                future: userFuture,
                builder: (context, snapshot) {
                  Usuario user = snapshot.data as Usuario;
                  // ignore: unnecessary_null_comparison
                  return user != null ? _drawerHeader(user) : Container();
                }),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("Mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("1");
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("Mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("1");
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _drawerHeader(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.login!),
      accountEmail: Text(user.email!),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto!),
      ),
    );
  }

  void _onClickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
