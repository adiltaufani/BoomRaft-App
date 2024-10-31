import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/main_screen.dart';
import 'package:flutter_project/services/auth_service.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:flutter_project/widgets/auth_password_field.dart';
import 'package:flutter_project/widgets/auth_texfield.dart';
import 'package:flutter_project/screens/auth_screen.dart';
import 'package:flutter_project/screens/forgot_password_screen.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/services/firebase_auth_service.dart';
import 'package:flutter_project/services/google_auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/router.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthService _auth = FirebaseAuthService();

  final _signInFormKey = GlobalKey<FormState>();
  final GoogleAuthService authService = GoogleAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkYellow,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 144,
              ),
              Container(
                  margin: EdgeInsets.all(30),
                  child: Image.asset(
                    'assets/images/boom_raft_logo.png',
                    height: 110,
                  )),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _signInFormKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => authService.signInWithGoogle(context),
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              color: Colors.black38,
                              width: 1.8,
                              strokeAlign: BorderSide.strokeAlignOutside),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Widget untuk gambar
                            Image.asset(
                              'assets/images/google-logo.png',
                              width: 26,
                              height: 26,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Login with Google',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'or',
                      style: GoogleFonts.outfit(
                        textStyle: const TextStyle(
                          color: AppTheme.darkBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: AuthTextField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: AuthPasswordField(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_signInFormKey.currentState!.validate()) {
                            await AuthService().loginUser(_emailController.text,
                                _passwordController.text);
                            currentScreen = HomeScreen();
                            Navigator.pushNamed(context, MainScreen.routeName);
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
                              'LOGIN',
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
                      height: 10,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an accont?",
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: const Color(0xFF3FA2F6).withOpacity(0.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AuthScreen.routeName);
                          },
                          child: Text(
                            'Sign up',
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
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Forgot your password?",
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: const Color(0xFF3FA2F6).withOpacity(0.5),
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
                            // Tambahkan logika yang ingin Anda jalankan ketika teks ditekan di sini
                            // Misalnya, untuk menavigasi ke layar login, Anda dapat menggunakan Navigator
                            Navigator.pushNamed(
                                context, ForgotPasswordScreen.routeName);
                          },
                          child: Text(
                            'Forgot password',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
