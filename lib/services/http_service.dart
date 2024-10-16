import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_project/models/user_model.dart';

class HttpService {
  final String ipaddr = "http://your-server-ip"; // Ganti dengan IP server

  Future<String> registerUser(UserModel user) async {
    final url = Uri.parse("$ipaddr/ta_projek/crudtaprojek/register.php");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to register user");
    }
  }
}
