import 'package:chat_app/common.dart';
import 'package:chat_app/screens/otp_verification_page.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PhoneNumberInputPage extends StatelessWidget {
  PhoneNumberInputPage({super.key});
  CountryCode? countryCode;
  String? verificationId;

  TextEditingController phoneNumberController = TextEditingController();

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
              "What's your number?",
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
              'Please enter your valid phone number.We will send you 4-digit code to verify your account.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              countryCodeWidget(),
              SizedBox(width: 20),
              SizedBox(
                width: 200,
                child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number),
              )
            ],
          ),
          SizedBox(height: 60),
          Center(
              child: SizedBox(
                  width: 260,
                  height: 55,
                  child: ElevatedButton(
                      onPressed: () {
                        if (phoneNumberController.text.isNotEmpty) {
                          print(
                              'country code : ${countryCode?.code} , number: ${phoneNumberController.text}');
                          if (phoneNumberController.text != null &&
                              countryCode?.dialCode != null) {
                            String phone =
                                "${countryCode?.dialCode}${phoneNumberController.text}";
                            verifyPhoneNumber(context, phone);
                            print('...............signin called');
                          } else {
                            if (countryCode == null) {
                              String phone = "+91${phoneNumberController.text}";
                              verifyPhoneNumber(context, phone);
                              print('...............signin called');
                              print('...country code null');
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Enter a valid phone number')));
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
        ]),
      ),
    );
  }

  verifyPhoneNumber(context, phone) async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Verification completed')));
        print('verification completed $phoneAuthCredential');
      },
      verificationFailed: (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Verification failed')));
        print('verification failed $error');
      },
      codeSent: (_verificationId, forceResendingToken) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Code sent')));
        print('code sent $_verificationId , $forceResendingToken');
        verificationId = _verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Timeout')));
        print(' codeAutoRetrievalTimeout $verificationId');
      },
    );
    if (verificationId != null) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return OtpVerificationPage(
            verificationId: verificationId!,
          );
        },
      ));
    }
  }

  countryCodeWidget() {
    return CountryCodePicker(
      onChanged: (code) {
        countryCode = code;

        print(
            '.........country name : ${countryCode?.name} dial code: ${countryCode?.dialCode} country code: ${countryCode?.code}');
      },
      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
      initialSelection: 'IN',
      showCountryOnly: false,
      // optional. Shows only country name and flag when popup is closed.
      showOnlyCountryWhenClosed: false,
      // optional. aligns the flag and the Text left
      alignLeft: false,
    );
  }
}
