import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.raleway(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFF0077B2),
        )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFF0077B2),
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Color.fromARGB(255, 0, 103, 154),
        )),
        hintStyle: TextStyle(
          color: Color(0xFF2FB0FA),
          fontFamily: 'OutfitBlod',
        ),
        fillColor: Color(0xFF0077B2).withOpacity(0.7),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
