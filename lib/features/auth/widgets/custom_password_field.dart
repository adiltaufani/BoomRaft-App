import 'package:flutter/material.dart';
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
          color: Color.fromARGB(255, 60, 129, 114),
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
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
        contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 10),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.white.withOpacity(0.82),
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
