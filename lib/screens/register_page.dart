import 'package:chat_app/screens/email_login_page.dart';
import 'package:chat_app/screens/email_verification_page.dart';
import 'package:chat_app/screens/first_page.dart';
import 'package:chat_app/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailWarning = '';
  String passwordWarning = '';
  String usernameWarning = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: mainRedColor,
                ),
              ),
              SizedBox(height: 150),
              SizedBox(
                width: 300,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(color: mainRedColor),
                      ),
                      SizedBox(height: 10),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  usernameWarning = '';
                                });
                              },
                              controller: usernameController,
                              cursorHeight: 25,
                              cursorColor: mainRedColor,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          )),
                      Text(
                        usernameWarning,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 25),
                      Text(
                        'E-mail',
                        style: TextStyle(color: mainRedColor),
                      ),
                      SizedBox(height: 10),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  emailWarning = '';
                                });
                              },
                              controller: emailController,
                              cursorHeight: 25,
                              cursorColor: mainRedColor,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          )),
                      Text(
                        emailWarning,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 25),
                      Text(
                        'Password',
                        style: TextStyle(color: mainRedColor),
                      ),
                      SizedBox(height: 15),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextFormField(
                              onTap: () {
                                setState(() {
                                  passwordWarning = '';
                                });
                              },
                              controller: passwordController,
                              cursorHeight: 25,
                              cursorColor: mainRedColor,
                              obscureText: true,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          )),
                      Text(
                        passwordWarning,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainRedColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onPressed: () {
                              setState(() {
                                String email = emailController.text;
                                String password = passwordController.text;
                                String username = usernameController.text;
                                bool validationSuccess = true;
                                if (email == null ||
                                    email == '' ||
                                    email.isEmpty) {
                                  emailWarning = 'Please enter an email';

                                  validationSuccess = false;
                                }

                                if (username == null ||
                                    username == '' ||
                                    username.isEmpty) {
                                  usernameWarning = 'Please enter a username';

                                  validationSuccess = false;
                                }

                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(email)) {
                                  emailWarning = 'Please enter a valid email';

                                  validationSuccess = false;
                                }

                                if (password == null ||
                                    password == '' ||
                                    password.isEmpty) {
                                  passwordWarning =
                                      'Please enter your password';

                                  validationSuccess = false;
                                }

                                if (validationSuccess = true &&
                                    emailController.text != null &&
                                    passwordController.text != null &&
                                    emailController.text != '' &&
                                    passwordController.text != '') {
                                  try {
                                    final user = FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text);

                                    FirebaseAuth.instance
                                        .authStateChanges()
                                        .listen((User? user) {
                                      if (user != null) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (ctx) {
                                          return EmailVerificationPage();
                                        }));
                                      }
                                    });
                                  } catch (e) {}
                                }
                              });
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
