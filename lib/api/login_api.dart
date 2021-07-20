import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<bool> login(String login, String senha) async {
    var url = Uri.parse('https://carros-springboot.herokuapp.com/api/v2/login');

    Map<String, String> headers = {"Content-type": "application/json"};

    Map params = {"username": login, "password": senha};

    //Recebe o Map e transforma em string
    String stringParams = json.encode(params);

    var response = await http.post(url, body: stringParams, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return true;
  }
}
