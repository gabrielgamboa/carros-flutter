import 'dart:convert';
import 'package:carros/api/api_response.dart';
import 'package:carros/models/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    Uri url = Uri.parse('https://carros-springboot.herokuapp.com/api/v2/login');

    Map<String, String> headers = {"Content-type": "application/json"};

    Map params = {"username": login, "password": senha};

    //Recebe o Map e transforma em string
    String stringParams = json.encode(params);

    var response = await http.post(url, body: stringParams, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> responseMap = json.decode(response.body);

    if (response.statusCode == 200) {
      final Usuario usuario = Usuario.fromJson(responseMap);

      //construtor nomeado "ok" para caso a requisição tiver êxito
      return ApiResponse.ok(usuario);
    }
    //construtor nomeado "error" para caso a requisição não tiver êxito
    return ApiResponse.error(responseMap["error"]);
  }
}
