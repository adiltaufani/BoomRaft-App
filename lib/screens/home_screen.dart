import 'package:flutter/material.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:flutter_project/widgets/book_btn.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: AppTheme.backgroundColor,
        child: Column(
          children: [
            Container(
              height: 260,
              width: double.maxFinite,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
                image: const DecorationImage(
                    image: AssetImage('assets/images/rafting.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Container(
                    height: 260,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black87.withOpacity(0.4)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 270),
                          child: Text(
                            'Enjoy a trip with us exploring the Palayangan River !',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Pangalengan, Bandung',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.6,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20,
                        color: const Color.fromARGB(255, 27, 94, 32),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'For you',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  //ubah ke GET nnt
                  BookBtn(
                      typeOfRafting: 'Small Raft',
                      detail: '4 People',
                      price: 'Rp. 700.000'),
                  BookBtn(
                      typeOfRafting: 'Medium Raft',
                      detail: '5 People',
                      price: 'Rp. 900.000'),
                  BookBtn(
                      typeOfRafting: 'Large Raft',
                      detail: '6 People',
                      price: 'Rp. 1.050.000'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
