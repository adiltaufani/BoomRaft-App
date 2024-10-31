import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Warna Utama Aplikasi
  static const Color darkBlue = Color(0xFF0F67B1);
  static const Color lightBlue = Color(0xFF3FA2F6);
  static const Color darkYellow = Color(0xFFFDEC55);
  static const Color lightYellow = Color(0xFFFFF492);
  static const Color backgroundColor = Color(0xFFFAFFCC);

  // Warna teks
  static const Color textPrimaryColor = Colors.black;
  static const Color textSecondaryColor = Colors.black54;

  // Warna tombol
  static const Color buttonColor = Color(0xFF1D976C);
  static const Color buttonTextColor = Colors.white;

  // Warna ikon dan app bar
  static const Color appBarColor = Color(0xFF1D976C);
  static const Color iconColor = Colors.white;

  static TextStyle settingTextStyle = GoogleFonts.montserrat(
      textStyle: const TextStyle(
    fontSize: 18,
    color: Color.fromARGB(221, 51, 32, 32),
    fontWeight: FontWeight.w500,
  ));

  static TextStyle paymentMethodeTextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      color: Colors.black87,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.2,
    ),
  );
}
