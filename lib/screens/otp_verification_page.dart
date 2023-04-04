import 'package:chat_app/widgets/terms_n_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

import '../common.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

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
              'Enter 4-digit code we have sent to you at +0 000 000 0000',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 60),
          Center(
            child: SizedBox(
              width: 300,
              child: PinCodeFields(
                length: 4,
                fieldBorderStyle: FieldBorderStyle.square,
                fieldHeight: 60,
                borderWidth: 1.0,
                activeBorderColor: mainRedColor,
                borderRadius: BorderRadius.circular(12),
                keyboardType: TextInputType.number,
                onComplete: (value) {
                  print('Completed');
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
                        Navigator.pushNamed(context,
                            '/LoginPage/PhoneNumberInputPage/OtpVerificationPage/BuildProfile');
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
