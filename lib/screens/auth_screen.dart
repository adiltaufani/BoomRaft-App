import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_password_field.dart';
import 'package:flutter_project/widgets/custom_texfield.dart';
import 'package:flutter_project/screens/login_screen.dart';
import 'package:flutter_project/services/firebase_auth_service.dart';
import 'package:flutter_project/services/google_auth_service.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/themes/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project/models/user_model.dart';
import 'package:flutter_project/services/http_service.dart';

import 'package:http/http.dart' as http;

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final GoogleAuthService authService = GoogleAuthService();

  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _repeatpasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkYellow,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Image.asset(
              'assets/images/logo_pineustilu_w.png',
            )),
            const SizedBox(height: 20),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 30),
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
                      width: 24,
                      height: 24,
                    ),
                    // Widget untuk teks
                    Text(
                      'Sign up with Google',
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
            const Text(
              'or',
              style: TextStyle(
                fontFamily: 'OutfitBlod',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Form(
              key: _signUpFormKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 34, right: 5, top: 8),
                          child: CustomTextField(
                              controller: _nameController,
                              hintText: 'First Name'),
                        ),
                      ),
                      // Spasi antara dua TextField
                      Expanded(
                        child: Container(
                          padding:
                              const EdgeInsets.only(right: 34, left: 5, top: 8),
                          child: CustomTextField(
                              controller: _lastnameController,
                              hintText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 34, vertical: 15),
                    child: CustomTextField(
                      controller: _emailController,
                      hintText: 'E-mail',
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 34, vertical: 0),
                    child: CustomPasswordField(
                      controller: _passwordController,
                      hintText: 'Password',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 34, vertical: 15),
                    child: CustomPasswordField(
                      controller: _repeatpasswordController,
                      hintText: 'Repeat password',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_signUpFormKey.currentState!.validate()) {
                          _signUp();
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
                            'SIGN UP',
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
                        'Already have an accont?',
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
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: Text(
                          'Login',
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
            )
          ],
        ),
      ),
    );
  }

  final HttpService _httpService = HttpService();

  Future _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    String firstName = _nameController.text;
    String lastName = _lastnameController.text;

    User? user = await _auth.signUpWithEmailAndPassword(
        email, password, firstName, lastName);

    if (user != null) {
      UserModel newUser = UserModel(
        uid: user.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
      );

      // Menggunakan HttpService untuk melakukan request pendaftaran
      String response = await _httpService.registerUser(newUser);

      if (response == "Success") {
        Navigator.pushNamed(context, HomeScreen.routeName);
        print("Successfully created");
      } else {
        print("Error: $response");
      }
    } else {
      print('some error occured');
    }
  }

  //  FUNGSI SEBELUMNYA
  //
  // Future<void> register() async {
  //   var url = Uri.parse("${ipaddr}/ta_projek/crudtaprojek/register.php");
  //   String firstName = _nameController.text;
  //   String lastName = _lastnameController.text;
  //   String email = _emailController.text;

  //   User? user = FirebaseAuth.instance.currentUser;
  //   String uid = user!.uid;

  //   final response = await http.post(
  //     Uri.parse('${ipaddr}/ta_projek/crudtaprojek/register.php'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode({
  //       'nama': firstName + lastName,
  //       'firstname': firstName,
  //       'lastname': lastName,
  //       'email': email,
  //       'uid': uid,
  //     }),
  //   );

  //   var data = json.decode(response.body);
  //   if (data == "Error") {
  //     // User already exist
  //     print("User already exists");
  //   } else {
  //     // Registration successful
  //     print("Registration successful");
  //   }
  // }
  // Future _signUp() async {
  //   String email = _emailController.text;
  //   String password = _passwordController.text;
  //   String firstName = _nameController.text;
  //   String lastName = _lastnameController.text;
  //   User? user = await _auth.signUpWithEmailAndPassword(
  //       email, password, firstName, lastName);

  //   if (user != null) {
  //     register();
  //     Navigator.pushNamed(context, HomeScreen.routeName);
  //     print("Succesfully created");
  //   } else {
  //     print('some error occured');
  //   }
  // }
}
