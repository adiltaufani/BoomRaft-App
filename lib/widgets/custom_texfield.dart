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
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: Color(0xFF0F67B1),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Atur corner radius di sini
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF0F67B1),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF0F67B1),
              width: 1.8,
            )),
        hintStyle: TextStyle(
          color: const Color(0xFF0F67B1).withOpacity(0.4),
          fontFamily: 'OutfitBlod',
        ),
        fillColor: const Color(0xFF96C9F4).withOpacity(0.6),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
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
