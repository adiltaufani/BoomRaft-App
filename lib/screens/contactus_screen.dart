import 'package:flutter/material.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactusScreen extends StatefulWidget {
  const ContactusScreen({super.key});

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  void _openWhatsApp() async {
    const url = 'https://wa.me/'; // Bisa menambahkan nomor WhatsApp di sini
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Fungsi untuk membuka Instagram
  void _openInstagram() async {
    const url = 'https://instagram.com/'; // Bisa menambahkan username di sini
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
            child: Container(
          color: AppTheme.backgroundColor,
        )),
        Positioned(
            bottom: -170,
            right: -60,
            left: -60,
            child: Image.asset('assets/images/contactus_bg.png')),
        Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.messenger_outline_rounded),
                  const SizedBox(width: 12),
                  Text(
                    'Contact Us',
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.all(30),
                  child: Image.asset(
                    'assets/images/boom_raft_logo.png',
                    height: 110,
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Column(
                  children: [
                    Text(
                      'LETS GET IN TOUCH',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: AppTheme.darkBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      'We want to hear from you. Let us know how we can help',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: AppTheme.darkBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'Send us a message here',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color(0xFFB4A41A),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF40C351),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.2), // Warna bayangan dengan opasitas
                          spreadRadius: 1, // Ukuran penyebaran bayangan
                          blurRadius: 2, // Tingkat kabur pada bayangan
                          offset: const Offset(
                              0, 2), // Posisi bayangan (horizontal, vertikal)
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _openWhatsApp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Whatsapp',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/images/wa_logo.png',
                            scale: 1.6,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.purple],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.2), // Warna bayangan dengan opasitas
                          spreadRadius: 1, // Ukuran penyebaran bayangan
                          blurRadius: 2, // Tingkat kabur pada bayangan
                          offset: const Offset(
                              0, 2), // Posisi bayangan (horizontal, vertikal)
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _openInstagram,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 80,
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Instagram',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/images/insta_logo.png',
                            scale: 1.65,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ],
    );
  }
}
