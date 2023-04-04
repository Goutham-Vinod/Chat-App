import 'package:chat_app/common.dart';
import 'package:chat_app/screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: Center(
        child: Container(
          height: 500,
          width: 350,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 158, 158, 158).withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'E-mail Verification',
                style: TextStyle(
                    color: mainRedColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: 300,
                child: Text(
                  'Please verify your Gmail by following the link sent to your E-mail.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 250),
              SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainRedColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () async {
                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((User? user) {
                        if (user != null) {
                          user.sendEmailVerification();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Verification link sent to your email')));
                        }
                      });
                    },
                    child: Text('Sent verificaton link'),
                  )),
              SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () async {
                      bool isEmailVerified = false;
                      FirebaseAuth.instance.currentUser?.reload();
                      User? _currentUser = FirebaseAuth.instance.currentUser;
                      print(_currentUser);
                      isEmailVerified = _currentUser!.emailVerified;
                      if (isEmailVerified) {
                        // here account created
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(_currentUser.uid)
                            .set({
                          'UserDetails': {
                            'name': '${_currentUser.displayName}',
                          }
                        });

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return ProfilePage();
                        }));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Email is not verified.Please visit you email for verification.If you already verified via email then please wait and try aftersome time."),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
