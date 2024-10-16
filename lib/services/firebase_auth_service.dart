import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String firstname, String lastname) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _firestore.collection('Users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
      });

      return credential.user;
    } catch (e) {
      print('Some error occured');
    }

    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      //create user
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user info
      _firestore.collection('Users').doc(credential.user!.uid).set({
        'uid': credential.user!.uid,
        'email': email,
      });

      return credential.user;
    } catch (e) {
      print('Some error occurred: $e');
    }

    return null;
  }
}
