import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String apiUrl = dotenv.env['API_URL'] ?? 'Default URL';

  Future<void> registerUser(
      String firstName, String lastName, String email, String password) async {
    final url = Uri.parse('$apiUrl/api/users/register');
    Map<String, String> userData = {
      'name': "$firstName $lastName",
      'email': email,
      'password': password,
    };

    try {
      print(userData);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        print('Signup successful: ${jsonDecode(response.body)}');
      } else {
        throw Exception('Failed to sign up');
      }
    } catch (e) {
      throw Exception('Error signing up:$e');
    }
  }

  Future<void> loginUser(String email, String password) async {
    final url = Uri.parse('$apiUrl/api/users/login');
    Map<String, dynamic> userData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Ambil token dari response
        final token = responseData['token'];

        // Simpan token di SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        print('Login successful, token saved: $token');
      } else {
        throw Exception('Failed to log in');
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }
}
