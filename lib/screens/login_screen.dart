import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_password_field.dart';
import 'package:flutter_project/widgets/custom_texfield.dart';
import 'package:flutter_project/screens/auth_screen.dart';
import 'package:flutter_project/screens/forgot_password_screen.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/services/firebase_auth_service.dart';
import 'package:flutter_project/services/google_auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Color(0xFF50B498),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/logo_pineustilu_w.png',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _signInFormKey,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: CustomTextField(
                      controller: _emailController,
                      hintText: 'Email',
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: CustomPasswordField(
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
                      onPressed: () {
                        if (_signInFormKey.currentState!.validate()) {
                          _signIn();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LOGIN',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 60, 129, 114),
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'or',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => authService.signInWithGoogle(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        // Tetap gunakan padding yang sesuai
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

                          // Widget untuk teks
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an accont?",
                        style: TextStyle(
                          fontFamily: 'OutfitBlod',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 21, 120, 100),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Tambahkan logika yang ingin Anda jalankan ketika teks ditekan di sini
                          // Misalnya, untuk menavigasi ke layar login, Anda dapat menggunakan Navigator
                          Navigator.pushNamed(context, AuthScreen.routeName);
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'OutfitBlod',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot your password?",
                        style: TextStyle(
                          fontFamily: 'OutfitBlod',
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 21, 120, 100),
                        ),
                      ),
                      SizedBox(
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
                          style: TextStyle(
                            fontFamily: 'OutfitBlod',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print("Successfully signed in");
      Navigator.pushNamed(context, HomeScreen.routeName);
    } else {
      print('Some error occurred');
      Fluttertoast.showToast(
        msg: "Incorrect email or password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
