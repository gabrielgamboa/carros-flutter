import 'package:carros/models/carro.dart';
import 'package:carros/models/usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum TipoCarro { classicos, esportivos, luxo }

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url = Uri.parse(
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo');

    Usuario? user = await Usuario.get();

    Map<String, String> headers = {
      "Content-type": "application/json",
      "Authorization": "Bearer ${user!.token}"
    };

    var response = await http.get(url, headers: headers);

    String json = response.body;

    List<dynamic> list = convert.json.decode(json);

    /// new List<Carro>(); foi depreciado pelo null safety, terá de ser usado:
    /// or final List<Carro> carros = List<Carro>.empty(growable: true); , ou:
    final List<Carro> carros =
        list.map<Carro>((carro) => Carro.fromJson(carro)).toList();

    return carros;
  }
}
