import 'package:chat_app/screens/profile_page.dart';
import 'package:chat_app/widgets/terms_n_conditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../common.dart';

class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({required this.verificationId, super.key});
  String verificationId;
  String? otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 60),
          SizedBox(
            width: 250,
            child: Text(
              "Enter Your Code",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w800,
                color: mainRedColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: Text(
              'Enter 6-digit code we have sent to you at +0 000 000 0000',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 60),
          Center(
            child: SizedBox(
              width: 300,
              child: PinCodeFields(
                length: 6,
                fieldBorderStyle: FieldBorderStyle.square,
                fieldHeight: 50,
                borderWidth: 1.0,
                activeBorderColor: mainRedColor,
                borderRadius: BorderRadius.circular(12),
                keyboardType: TextInputType.number,
                onComplete: (value) {
                  print('Completed $value');
                  otp = value;
                },
              ),
            ),
          ),
          Spacer(),
          Center(
              child: SizedBox(
                  width: 260,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        if (otp != null) {
                          try {
                            final _credential = PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: otp!);
                            FirebaseAuth.instance
                                .signInWithCredential(_credential)
                                .then((result) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return ProfilePage();
                                },
                              ));
                            });
                          } catch (e) {}
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainRedColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0))),
                      child: Text(
                        'Continue',
                        style: TextStyle(fontSize: 18),
                      )))),
          SizedBox(height: 25),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () => showPrivacyPolicy(context),
                  child: Text('Privacy Policy')),
              GestureDetector(
                  onTap: () => showAboutUs(context), child: Text('About Us')),
            ],
          )),
          SizedBox(height: 25),
        ]),
      ),
    );
  }
}
