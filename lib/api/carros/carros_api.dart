import 'package:carros/models/carro.dart';

class CarrosApi {
  static List<Carro> getCarros() {
    /// new List<Carro>(); foi depreciado pelo null safety, terá de ser usado:
    /// or final List<Carro> carros = List<Carro>.empty(growable: true); , ou:
    final List<Carro> carros = []; 

    carros.add(new Carro(nome: "AUDI GT Spyder", urlFoto: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Ferrari_FF.png"));
    carros.add(new Carro(nome: "Porsche Panamera", urlFoto: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Porsche_Panamera.png"));
    carros.add(new Carro(nome: "Lamborghini Aventador", urlFoto: "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/esportivos/Lamborghini_Aventador.png"));

    return carros;
  }
}