import 'dart:convert';
import 'package:flutter_project/models/boat_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BoatService {
  final String apiUrl = dotenv.env['API_URL'] ?? 'Default URL';

  // Menambahkan DateTime ke query string
  Future<List<Boat>> fetchBoats(String bearerToken, String startDate) async {
    // Menambahkan parameter DateTime ke query string URL
    final url =
        Uri.parse('$apiUrl/api/boat/available-boats?dateTime=$startDate');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $bearerToken', // Menambahkan Bearer token
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      // Parsing response body yang berupa JSON
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      // Mengubah data JSON menjadi List<Boat>
      List<Boat> boats =
          data.map((boatJson) => Boat.fromJson(boatJson)).toList();
      print(boats);
      return boats;
    } else {
      throw Exception('Failed to load boats');
    }
  }
}
