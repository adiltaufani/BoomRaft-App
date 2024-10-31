import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/services/auth_service.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkYellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'Enter OTP',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  color: AppTheme.darkBlue,
                  fontSize: 44,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.6,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30.0),
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              'We have sent the verification code to your email',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppTheme.darkBlue.withOpacity(0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Form(
            key: formKey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Pinput(
                  controller: otpController,
                  length: 4,
                  defaultPinTheme: PinTheme(
                    width: 76,
                    height: 76,
                    textStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: AppTheme.darkBlue,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF96C9F4).withOpacity(0.6),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppTheme.darkBlue
                            .withOpacity(0.6), // Sesuaikan warna
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 62,
            ),
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final validate =
                      await AuthService().validateOtp(otpController.text);
                  if (validate) {
                    Navigator.pushNamed(context, MainScreen.routeName);
                  }

                  // await AuthService().validateOtp(userid, otpController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: AppTheme.darkBlue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'VERIFY',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't get the OTP code?",
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    color: const Color(0xFF3FA2F6).withOpacity(0.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: () {
                  //
                },
                child: Text(
                  'Resend',
                  style: GoogleFonts.outfit(
                    textStyle: const TextStyle(
                      color: AppTheme.darkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
