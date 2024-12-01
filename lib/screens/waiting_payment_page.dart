import 'package:flutter/material.dart';
import 'package:flutter_project/routes/router.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/screens/transaction_screen.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitingPaymentPage extends StatefulWidget {
  static const String routeName = '/waiting-payment';
  const WaitingPaymentPage({super.key});

  @override
  State<WaitingPaymentPage> createState() => _WaitingPaymentPageState();
}

bool isMethode1Exp = false;
bool isMethode2Exp = false;

class _WaitingPaymentPageState extends State<WaitingPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: AppTheme.lightYellow,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 180,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      'assets/images/boom_raft_logo.png',
                      height: 110,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          // Mengubah _currentScreen menjadi NotificationPage saat tombol ditekan
                          currentScreen = const HomeScreen();
                          Navigator.pushNamed(context, MainScreen.routeName);
                        });
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Waiting for payment',
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                )),
                              ),
                              Icon(Icons.timelapse_rounded)
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Payment',
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                              Text(
                                'Rp. 700.000',
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: true,
                            child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(
                                          0.4), // Adjust opacity for shadow intensity
                                      spreadRadius:
                                          2, // Adjust for desired shadow spread
                                      blurRadius:
                                          2, // Adjust for desired blur amount
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(6)),
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 226),
                                margin: const EdgeInsets.all(14),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Pay Before',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '09:00 PM 01 Jan 2024',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Payment Methode',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Transfer BCA',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Reference Number',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '01234567890123',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total Payment',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Rp. 700.000',
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 40,
                                    ),
                                    Text(
                                      'How to do the payment',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        ListTile(
                                          contentPadding: const EdgeInsets.only(
                                              top: 0, left: 10, right: 10),
                                          title: Text(
                                            'Methode 1',
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                letterSpacing: -0.4,
                                              ),
                                            ),
                                          ),
                                          trailing: Icon(
                                            isMethode1Exp
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: Colors.black54,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              isMethode1Exp = !isMethode1Exp;
                                            });
                                          },
                                        ),
                                        if (isMethode1Exp)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'this is methode 1',
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ListTile(
                                          contentPadding: const EdgeInsets.only(
                                              top: 0, left: 10, right: 10),
                                          title: Text(
                                            'Methode 2',
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                letterSpacing: -0.4,
                                              ),
                                            ),
                                          ),
                                          trailing: Icon(
                                            isMethode2Exp
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: Colors.black54,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              isMethode2Exp = !isMethode2Exp;
                                            });
                                          },
                                        ),
                                        if (isMethode2Exp)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'this is methode 2',
                                                  style: GoogleFonts.montserrat(
                                                    textStyle: const TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 5, bottom: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              currentScreen = const HomeScreen();
                              Navigator.pushNamed(
                                  context, MainScreen.routeName);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(double.infinity, 52),
                              elevation: 2,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Adjust as needed
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Return Home",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: AppTheme.darkBlue,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 5, right: 10, bottom: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              currentScreen = const TransactionScreen();
                              Navigator.pushNamed(
                                  context, MainScreen.routeName);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(double.infinity, 52),
                              elevation: 2,
                              backgroundColor: AppTheme.darkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0), // Adjust as needed
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Look Transaction",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.6,
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
