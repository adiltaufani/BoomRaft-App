import 'dart:convert';
import 'package:flutter_project/models/reserv_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  String apiUrl = dotenv.env['API_URL'] ?? 'Default URL';

  Future<List<Reservation>> getReservation() async {
    final url = Uri.parse('$apiUrl/api/reservation/reservation');

    try {
      // Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken') ?? '';

      if (token.isEmpty) {
        throw Exception('No token found');
      }

      // Kirim permintaan dengan Bearer token di header
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        final a =
            responseData.map((item) => Reservation.fromJson(item)).toList();
        print('ressss: ${a.length}');
        return responseData.map((item) => Reservation.fromJson(item)).toList();
      } else {
        throw Exception('Failed to log in');
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }
}
