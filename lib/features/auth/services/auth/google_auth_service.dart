import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Jika login berhasil, navigasi ke HomeScreen
        Navigator.pushReplacementNamed(context, '/home-screen');
      }
    } catch (error) {
      print("Error during Google sign in: $error");
      // Tambahkan penanganan kesalahan sesuai kebutuhan
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      // Setelah berhasil logout, navigasi ke halaman login
      Navigator.pushReplacementNamed(context, '/login-screen');
    } catch (error) {
      print("Error during sign out: $error");
      // Tambahkan penanganan kesalahan sesuai kebutuhan
    }
  }
}
