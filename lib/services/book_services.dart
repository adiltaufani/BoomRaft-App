import 'dart:convert';
import 'package:flutter_project/services/token_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookServices {
  String apiUrl = dotenv.env['API_URL'] ?? 'Default URL';
  final tokenService = TokenService();

  Future<void> bookReservation(
    int boatId,
    String rsvDate,
    String rsvTime,
    int numberOfPeople,
    String paymentMethod,
    String gender,
    String phone,
    String city,
  ) async {
    final url = Uri.parse('$apiUrl/api/reservation/create-reservation');
    Map<String, dynamic> userData = {
      "boat_id": boatId,
      "rsv_date": rsvDate,
      "rsv_time": rsvTime,
      "number_of_people": numberOfPeople,
      "payment_method": paymentMethod,
      "gender": gender,
      "phone": phone,
      "city": city,
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
        throw Exception('Failed to book');
      }
    } catch (e) {
      throw Exception('booking Error: $e');
    }
  }
}
