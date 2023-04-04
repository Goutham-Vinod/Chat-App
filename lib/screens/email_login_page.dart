import 'package:chat_app/common.dart';
import 'package:chat_app/screens/home_page.dart';
import 'package:chat_app/screens/register_page.dart';
import 'package:chat_app/screens/test_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailLoginPage extends StatefulWidget {
  EmailLoginPage({super.key});

  @override
  State<EmailLoginPage> createState() => _EmailLoginPageState();
}

class _EmailLoginPageState extends State<EmailLoginPage> {
  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _passwordTextController = TextEditingController();

  String passwordWarning = '';

  String emailWarning = '';

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
                'Login',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: mainRedColor,
                ),
              ),
              SizedBox(height: 150),
              SizedBox(
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(color: mainRedColor),
                        ),
                        SizedBox(height: 15),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                onTap: () {
                                  setState(() {
                                    emailWarning = '';
                                  });
                                },
                                controller: _emailTextController,
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
                        SizedBox(height: 30),
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
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: TextFormField(
                                onTap: () {
                                  setState(() {
                                    passwordWarning = '';
                                  });
                                },
                                cursorHeight: 25,
                                cursorColor: mainRedColor,
                                obscureText: true,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                controller: _passwordTextController,
                              ),
                            )),
                        Text(
                          passwordWarning,
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 30),
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
                                login(context, _emailTextController.text,
                                    _passwordTextController.text);
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              )),
                        ),
                        SizedBox(
                          width: 300,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctx) {
                                  return RegisterPage();
                                }));
                              },
                              child: Text(
                                'Create an Account',
                                style: TextStyle(color: mainRedColor),
                              )),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(context, email, password) async {
    bool validationSuccess = true;
    if (email == null || email == '') {
      setState(() {
        emailWarning = 'Please enter an email';
      });
      validationSuccess = false;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() {
        emailWarning = 'Please enter a valid email';
      });
      validationSuccess = false;
    }

    if (password == null || password == '') {
      setState(() {
        passwordWarning = 'Please enter your password';
      });
      validationSuccess = false;
    }

    if (validationSuccess = true) {
      try {
        final currentUser = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user != null) {
            if (user.emailVerified) {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return Home();
              }));
              // currentUser = user;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Email is not verified"),
                ),
              );
              user.sendEmailVerification();
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("User Id and Password didn't match"),
              ),
            );
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User Id and Password didn't match")));
      }
    }
  }
}
