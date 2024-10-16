import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypeofBtn extends StatelessWidget {
  const TypeofBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(20),
          height: 170,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
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
                        'Type of Rafting',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.8,
                          ),
                        ),
                      ),
                      Text(
                        'Detail Here',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: Colors.black45,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.8,
                          ),
                        ),
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
                    'Rp._00.000,00',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color(0xFF286767),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF286767),
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
      ),
    );
  }
}
