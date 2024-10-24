import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FetchDataService {
  String apiUrl = dotenv.env['API_URL'] ?? 'Default URL';

  Future<void> fetchUserData(
      String firstname, String lastname, String email, String pp) async {
    var user = FirebaseAuth.instance.currentUser;

    // Pastikan user sudah login
    if (user == null) {
      // Jika user belum login, tampilkan pesan
      print("Silakan login terlebih dahulu");
      return; // Keluar dari metode fetchUserData
    }

    var url = Uri.parse("${apiUrl}/ta_projek/crudtaprojek/view_data.php");
    String uid = user.uid;
    var response = await http.post(url, body: {
      "uid": uid,
    });

    var data = json.decode(response.body);
    if (data != null) {
      // Data berhasil diterima, tampilkan firstname dan lastname
      firstname = data['firstname'];
      lastname = data['lastname'];
      email = data['email'];
      String cleanedUrlFoto = data['profile_picture'].replaceAll('\\', '');
      pp = cleanedUrlFoto;
      print('Firstname: $firstname, Lastname: $lastname');

      //ieu perlu kah???

      // setState(() {
      //   isDataAvail = false;
      //   print(pp);
      // });
    } else {
      print("Gagal mendapatkan data pengguna");
    }
  }
}
