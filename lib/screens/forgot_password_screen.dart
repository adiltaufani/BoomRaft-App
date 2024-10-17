import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/auth_texfield.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/services/google_auth_service.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-screen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _signInFormKey = GlobalKey<FormState>();
  final GoogleAuthService authService = GoogleAuthService();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 40),
              child: const Text(
                'Book-it',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OutfitBlod'),
              ),
            ),
            const Text(
              'Forgot your password',
              style: TextStyle(
                  color: Colors.white, fontSize: 15, fontFamily: 'OutfitLight'),
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
                    child: AuthTextField(
                      controller: _emailController,
                      hintText: 'E-mail',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_signInFormKey.currentState!.validate()) {
                          _signIn();
                        }
                      },
                      child: const Text(
                        'Send Email',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontFamily: 'OutfitBlod',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 120, vertical: 10),
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

  void _signIn() async {
    String email = _emailController.text;

    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) => {
                print("email sent!"),
                Get.off(() => LoginScreen()),
              });
    } on FirebaseAuthException catch (e) {
      print('Error $e');
    }
  }
}
