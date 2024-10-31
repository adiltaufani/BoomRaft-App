import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/services/token_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String apiUrl = dotenv.env['API_URL'] ?? 'Default URL';
  final tokenService = TokenService();

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
        final responseData = jsonDecode(response.body);

        final String token = responseData['user']?['token'];

        // Simpan token di SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        // print('Sign up successful, token saved: $token');
        return responseData;
      } else {
        throw Exception('Failed to sign up');
      }
    } catch (e) {
      throw Exception('Error signing up: $e');
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

  Future<void> signOut(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      // Setelah berhasil logout, navigasi ke halaman login
      Navigator.pushReplacementNamed(context, '/login-screen');
    } catch (error) {
      print("Error during sign out: $error");
      // Tambahkan penanganan kesalahan sesuai kebutuhan
    }
  }

  Future<bool> validateOtp(String otp) async {
    final url = Uri.parse('$apiUrl/api/users/verify-otp');
    Map<String, String> userData = {
      'otp': otp,
    };
    String? token = await tokenService.getToken();

    try {
      print(token);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token', // Menambahkan Bearer token
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error OTP: $e');
    }
  }
}
