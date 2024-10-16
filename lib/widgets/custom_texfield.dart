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
          color: Color.fromARGB(255, 60, 129, 114),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0x0077B2),
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Color.fromARGB(210, 60, 129, 114),
          width: 2,
        )),
        hintStyle: TextStyle(
          color: Color(0xFF468585).withOpacity(0.4),
          fontFamily: 'OutfitBlod',
        ),
        fillColor: Color.fromARGB(255, 242, 252, 231),
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
