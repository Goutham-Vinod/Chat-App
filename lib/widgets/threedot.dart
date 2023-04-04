import 'dart:convert';
import 'dart:developer';

import 'package:chat_app/db/db_functions.dart';
import 'package:chat_app/screens/profile_page.dart';
import 'package:chat_app/screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ThreeDot extends StatelessWidget {
  ThreeDot();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        size: 20,
      ),
      itemBuilder: (context) {
        List<PopupMenuItem<String>> popupMenuItemList = [
          PopupMenuItem(value: "Profile", child: Text("Profile")),
          PopupMenuItem(value: "Settings", child: Text("Settings")),
          PopupMenuItem(value: "Log out", child: Text("Log out"))
        ];
        return popupMenuItemList;
      },
      onSelected: (String? value) {
        if (value != null) {
          switch (value) {
            case 'Profile':
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return ProfilePage();
              }));
              break;
            case 'Log out':
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, '/FirstPage');
              break;
            case 'Settings':
              print('Settings page not designed yet');
              DbFunctions().readData();
              break;
            default:
          }
        }
      },
    );
  }
}
