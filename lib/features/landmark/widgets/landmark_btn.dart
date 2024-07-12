import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LandmarkBtn extends StatefulWidget {
  final String placeName;
  final String imagePath;

  const LandmarkBtn(
      {Key? key, required this.placeName, required this.imagePath})
      : super(key: key);

  @override
  State<LandmarkBtn> createState() => _LandmarkBtnState();
}

class _LandmarkBtnState extends State<LandmarkBtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          children: [
            // Background Image with Rounded Corners
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: NetworkImage(widget.imagePath), fit: BoxFit.cover),
                ),
              ),
            ),
            // Shadow Overlay
            SizedBox(
              height: 20,
            ),
            // Text Overlay
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget
                          .placeName, // Menggunakan widget.placeName dari State
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.6,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
