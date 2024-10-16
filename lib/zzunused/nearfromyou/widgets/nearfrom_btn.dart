import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NearFromBtn extends StatefulWidget {
  const NearFromBtn({super.key});

  @override
  State<NearFromBtn> createState() => _NearFromBtnState();
}

class _NearFromBtnState extends State<NearFromBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 24, top: 16, bottom: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Image with Rounded Corners
          Material(
            elevation: 5, // Atur elevasi sesuai kebutuhan
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 210,
              height: 260,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(15), // Adjust the radius as needed
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(15), // Adjust the radius as needed
                child: Image.asset(
                  'assets/images/image_widget.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ),
          // Shadow Overlay
          Container(
            width: 210,
            height: 260,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(10), // Adjust the radius as needed
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(
                      0.68), // Opacity untuk membuatnya lebih gelap
                  Colors.transparent, // Untuk memberikan transisi ke gambar
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              width: 72,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '2.0 km',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Text Overlay
          Positioned(
            bottom: 12,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dreamsville House',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.6,
                    ),
                  ),
                ),
                Text(
                  'Jl. Sultan Iskandar Muda',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
