import 'package:flutter/material.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: AppTheme.darkBlue,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
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
          color: AppTheme.darkBlue.withOpacity(0.4),
          fontFamily: 'OutfitBlod',
        ),
        fillColor: const Color(0xFF96C9F4).withOpacity(0.6),
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppTheme.darkBlue.withOpacity(0.82),
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter your ${widget.hintText}';
        }
        return null;
      },
    );
  }
}
