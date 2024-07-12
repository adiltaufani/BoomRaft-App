import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_project/variables.dart';
import 'package:http/http.dart' as http;

class ProfileDataManager {
  static Future<String?> getProfilePic() async {
    var user = FirebaseAuth.instance.currentUser;

    // Pastikan user sudah login
    if (user == null) {
      // Jika user belum login, tampilkan pesan atau return null
      print("Silakan login terlebih dahulu");
      return null;
    }

    var url = Uri.parse("${ipaddr}/ta_projek/crudtaprojek/view_data.php");
    String uid = user.uid;
    var response = await http.post(url, body: {
      "uid": uid,
    });

    var data = json.decode(response.body);
    if (data != null) {
      // Data berhasil diterima, kembalikan URL foto profil
      String cleanedUrlFoto = await getImageUrl("images/image_$uid.jpg");
      return cleanedUrlFoto;
    } else {
      print("Gagal mendapatkan data pengguna");
      return "https://firebasestorage.googleapis.com/v0/b/loginsignupta-prototype.appspot.com/o/images%2Fdefault.webp?alt=media&token=0f99eb8a-be98-4f26-99b7-d71776562de9";
    }
  }

  static Future<String?> getImageChat(String user_uid) async {
    String cleanedUrlFoto =
        await await getImageUrl("images/image_$user_uid.jpg");
    return cleanedUrlFoto;
  }

  static Future<String> getImageUrl(String imagePath) async {
    try {
      // Buat referensi Firebase Storage untuk gambar yang diunggah
      Reference ref = FirebaseStorage.instance.ref().child(imagePath);

      // Dapatkan URL download gambar
      String imageUrl = await ref.getDownloadURL();

      // Kembalikan URL download gambar
      return imageUrl;
    } catch (error) {
      // Tangkap error dan kembalikan URL gambar default jika terjadi kesalahan
      print("Error: $error");
      // Mengembalikan URL gambar default dari assets jika terjadi kesalahan
      return "https://firebasestorage.googleapis.com/v0/b/loginsignupta-prototype.appspot.com/o/images%2Fdefault.webp?alt=media&token=0f99eb8a-be98-4f26-99b7-d71776562de9";
    }
  }
}
