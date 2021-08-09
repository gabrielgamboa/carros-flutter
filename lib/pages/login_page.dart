import 'package:carros/api/login_api.dart';
import 'package:carros/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:carros/utils/nav.dart';
import 'package:carros/pages/home_page.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _tLogin = TextEditingController();
  final _tPassword = TextEditingController();
  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            //passa o nextFocus indicando qual foco ir
            AppText("E-mail", "Digite seu e-mail",
                controller: _tLogin,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                nextFocus: _focusSenha, validator: (text) {
              if (text!.isEmpty) {
                return "Digite o e-mail!!!";
              }
              return null;
            }),
            SizedBox(
              height: 10,
            ),
            // passa o focusNode o seu foco
            AppText("Senha", "Digite sua senha",
                controller: _tPassword,
                keyboardType: TextInputType.number,
                focusNode: _focusSenha, validator: (text) {
              if (text!.isEmpty) {
                return "Digite a senha!!!";
              }
              return null;
            }, password: true),
            SizedBox(
              height: 20,
            ),
            AppButton('Login', onPressed: _onClickLogin,)
          ],
        ),
      ),
    );
  }



  void _onClickLogin() async {
    bool formOk = _formKey.currentState!.validate();

    if (!formOk) {
      return;
    }

    String email = _tLogin.text;
    String senha = _tPassword.text;


    Usuario usuario = await LoginApi.login(email, senha);

    // ignore: unnecessary_null_comparison
    if (usuario != null) {
      print("$usuario");

      push(context, HomePage());
    } else {
      print('Erro ao realizar login!');
    }
  }
}