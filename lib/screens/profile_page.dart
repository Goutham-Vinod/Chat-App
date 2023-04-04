import 'dart:io';

import 'package:chat_app/common.dart';
import 'package:chat_app/widgets/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  File? dpImage;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    if (user != null) {
      String name = user?.displayName ?? '';
      nameController.text = name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              SizedBox(
                  width: 150,
                  child: InkWell(
                    onTap: () {
                      getImageFromCamera(context);
                    },
                    child: Stack(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 158, 158, 158)
                                        .withOpacity(0.4),
                                    spreadRadius: 10,
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Image.asset('assets/default_dp.png')),
                        Positioned(
                            bottom: 2,
                            right: 12,
                            child: Icon(
                              Icons.add_circle_outlined,
                              color: Colors.grey,
                              size: 40,
                            )),
                      ],
                    ),
                  )),
              SizedBox(height: 40),
              Text(
                'Profile',
                style: TextStyle(
                    color: mainRedColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Name',
                    style: TextStyle(color: mainRedColor, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        cursorHeight: 25,
                        controller: nameController,
                        cursorColor: mainRedColor,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
              SizedBox(
                width: 260,
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc('${FirebaseAuth.instance.currentUser?.uid}')
                          .update(
                              {'UserDetails.name': '${nameController.text}'});

                      user?.updateDisplayName(nameController.text);

                      Navigator.pushNamed(context, '/Home');
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainRedColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
