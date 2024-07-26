import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Future<void> signup({
    // required String username,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // ignore: non_constant_identifier_names
      String Message = '';
      if (e.code == 'weak password') {
        Message = 'The Password is to weak';
      } else if (e.code == 'email-already-in-use') {
        Message = 'an account already exists with that email';
      }
      Fluttertoast.showToast(
          msg: Message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          fontSize: 14.0);
    } catch (e) {
      print(e);
    }
  }
}
