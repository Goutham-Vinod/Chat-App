import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hello',
              style: GoogleFonts.dancingScript(
                fontSize: 100,
                color: mainRedColor,
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Sign in to continue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 80),
            SizedBox(
              height: 50,
              width: 280,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainRedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    print('Not working');
                    // Navigator.pushNamed(
                    //     context, '/LoginPage/PhoneNumberInputPage');
                  },
                  child: Text(
                    "Use Phone Number",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )),
            ),
            SizedBox(height: 30),
            //////////////////////////////////////
            SizedBox(
              height: 50,
              width: 280,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainRedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    Navigator.pushNamed(context, '/LoginPage/EmailLoginPage');
                  },
                  child: Text(
                    "Use Gmail",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
