import 'package:chat_app/screens/email_verification_page.dart';
import 'package:chat_app/screens/first_page.dart';
import 'package:chat_app/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoginState(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainRedColor,
      body: Center(
        child: Text(
          'Hello',
          style: GoogleFonts.dancingScript(
            fontSize: 100,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

checkLoginState(context) async {
  await Future.delayed(const Duration(seconds: 3));
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      if (user.emailVerified) {
        print('already logged in');
        // currentUser = user;
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return Home();
        }));
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return const FirstPage();
        }));
        print('Email not verified');
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return const FirstPage();
      }));
      print('logged in');
    }
  });
}
