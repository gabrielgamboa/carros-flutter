import 'package:carros/models/carro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CarrosApi {
  static Future<List<Carro>> getCarros() async {
    var url = Uri.parse('https://carros-springboot.herokuapp.com/api/v1/carros');

    var response = await http.get(url);

    String json = response.body;

    List list = convert.json.decode(json);

    /// new List<Carro>(); foi depreciado pelo null safety, terá de ser usado:
    /// or final List<Carro> carros = List<Carro>.empty(growable: true); , ou:
    final List<Carro> carros = list.map<Carro>((carro) => Carro.fromJson(carro)).toList(); 
    
    return carros;
  }
}