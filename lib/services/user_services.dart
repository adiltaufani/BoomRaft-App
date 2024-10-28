import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  String apiUrl = dotenv.env['API_URL'] ?? 'Default URL';

  Future<Map<String, dynamic>> getProfile() async {
    final url = Uri.parse('$apiUrl/api/users/profile');

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
        final responseData = jsonDecode(response.body);
        print('User profile: $responseData');
        return responseData;
      } else {
        throw Exception('Failed to log in');
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }
}
