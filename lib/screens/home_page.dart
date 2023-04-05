import 'package:chat_app/common.dart';
import 'package:chat_app/db/db_model.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/widgets/threedot.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_list_tile.dart';

class Home extends StatelessWidget {
  Home({super.key});
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // centerTitle: true,
        shadowColor: Colors.transparent,
        actionsIconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          'Hello',
          style: GoogleFonts.dancingScript(
            fontSize: 25,
            color: mainRedColor,
          ),
        ),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ThreeDot(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (context, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (streamSnapshot.hasError) {
              return Center(child: Text('Sorry... Something went wrong...'));
            }
            if (streamSnapshot.hasData) {
              // Extract the document IDs from the QuerySnapshot
              List<String> documentIds =
                  streamSnapshot.data!.docs.map((doc) => doc.id).toList();
              return ListView.builder(
                itemCount: streamSnapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  if (documentIds[index] != user?.uid) {
                    return CustomListTile(
                      title: streamSnapshot.data?.docs[index]
                          .data()['UserDetails']['name'],
                      subtitle: '',
                      dpUrl: streamSnapshot.data?.docs[index]
                          .data()['UserDetails']['dpUrl'],
                      onTapFunction: () {
                        FriendDetails friend = FriendDetails(
                            friendId: streamSnapshot.data?.docs[index].id ?? '',
                            friendName: streamSnapshot.data?.docs[index]
                                .data()['UserDetails']['name'],
                            friendDp: streamSnapshot.data?.docs[index]
                                .data()['UserDetails']['dpUrl']);

                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return ChatPage(friend: friend);
                        }));
                      },
                      // unReadMsgCount: 15,
                    );
                  } else {
                    return Text('');
                  }
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
