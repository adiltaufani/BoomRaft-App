import 'package:flutter/material.dart';
import 'package:flutter_project/screens/booking_page.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class BookBtn extends StatelessWidget {
  final String typeOfRafting; // Menambahkan variabel typeOfRafting
  final String detail; // Menambahkan variabel detail
  final String price;

  const BookBtn({
    super.key,
    required this.typeOfRafting, // Inisialisasi variabel typeOfRafting
    required this.detail,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 170,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Warna bayangan
              spreadRadius: 2, // Penyebaran bayangan
              blurRadius: 3, // Jarak blur
              offset:
                  Offset(1, 3), // Posisi bayangan (x: horizontal, y: vertikal)
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/raft.png',
                  height: 60,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      typeOfRafting, // Menggunakan variabel typeOfRafting
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          detail, // Menggunakan variabel detail
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.8,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        const Icon(
                          Icons.people_alt,
                          size: 14,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Divider(
              color: Colors.black26,
              thickness: 0.8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: AppTheme.lightBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, BookingPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.darkBlue,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'Book',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
