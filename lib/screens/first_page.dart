import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainRedColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hello',
              style: GoogleFonts.dancingScript(
                fontSize: 100,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              '''A simple chat app 
for simple people..''',
              style: GoogleFonts.sriracha(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(height: 80),
            SizedBox(
              height: 50,
              width: 280,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/LoginPage');
                  },
                  child: Text(
                    "Let's Get Started",
                    style: TextStyle(
                        color: mainRedColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
