import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/email_login_page.dart';
import 'package:chat_app/screens/first_page.dart';
import 'package:chat_app/screens/home_page.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/otp_verification_page.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/screens/test_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      initialRoute: '/SplashScreen',
      routes: {
        '/FirstPage': (context) => FirstPage(),
        '/SplashScreen': (context) => SplashScreen(),
        '/LoginPage': (context) => LoginPage(),
        // '/LoginPage/PhoneNumberInputPage': (context) => PhoneNumberInputPage(),
        '/LoginPage/PhoneNumberInputPage/OtpVerificationPage': (context) =>
            OtpVerificationPage(),
        '/LoginPage/EmailLoginPage': (context) => EmailLoginPage(),
        // '/LoginPage/PhoneNumberInputPage/OtpVerificationPage/BuildProfile':
        //     (context) => BuildProfile(),
        '/Home': (context) => Home(),

        '/test': (context) => TestPage(),
      },
    );
  }
}
