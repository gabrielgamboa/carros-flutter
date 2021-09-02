import 'package:carros/models/carro.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

enum TipoCarro {
  classicos,
  esportivos,
  luxo
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    var url = Uri.parse('https://carros-springboot.herokuapp.com/api/v1/carros/tipo/$tipo');

    var response = await http.get(url);

    String json = response.body;

    List<dynamic> list = convert.json.decode(json);

    /// new List<Carro>(); foi depreciado pelo null safety, terá de ser usado:
    /// or final List<Carro> carros = List<Carro>.empty(growable: true); , ou:
    final List<Carro> carros = list.map<Carro>((carro) => Carro.fromJson(carro)).toList(); 
    
    return carros;
  }
}