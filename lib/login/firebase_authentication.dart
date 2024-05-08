// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/pages/list_news_page.dart';
import 'package:news_app/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loginByGoogle(BuildContext context) async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn.standard();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    //final FirebaseAuth firebaseAuth = FirebaseAuth;

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLogin', true);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) {
          return const ListNewsPage();
        },
      ));
    } else {
      throw FirebaseAuthException(code: "");
    }
  } on FirebaseAuthException catch (_) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Terjadi Kesalahan")));
  }
}

Future<void> signOut(context) async {
  try {
    await Future.wait([
      FirebaseAuth.instance.signOut(),
      GoogleSignIn().signOut(),
      //_facebookAuth.logOut()
    ]);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (_) {
        return const LoginPage();
      },
    ));
  } on FirebaseAuthException catch (_) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Terjadi Kesalahan")));
  }
}
