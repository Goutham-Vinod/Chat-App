import 'package:chat_app/common.dart';
import 'package:chat_app/db/db_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets/recieve_message_widget.dart';
import '../widgets/sent_message_widget.dart';

class ChatPage extends StatefulWidget {
  ChatPage({required this.friend, super.key});

  FriendDetails friend;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  User? currentUser;
  TextEditingController msgController = TextEditingController();
  @override
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: defaultBgColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          // automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.grey),
          centerTitle: true,
          shadowColor: Colors.transparent,
          actionsIconTheme: IconThemeData(color: Colors.grey),
          title: Text(
            widget.friend.friendName,
            style: TextStyle(
                color: mainRedColor, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(currentUser?.uid)
                  .snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Center(child: Text('Oops..Something went wrong!'));
                }
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (streamSnapshot.hasData) {
                  print('has data');
                  ///////////////////////////////////////////
                  List msgs = [];
                  try {
                    msgs = streamSnapshot.data?.get(widget.friend.friendId);
                  } catch (e) {}

                  return Expanded(
                    child: ListView.builder(
                      itemCount: msgs.length,
                      itemBuilder: (context, index) {
                        print('inside list view');
                        final msg = msgs[index];
                        if (msg['isRecieved'] == true) {
                          return RecieveMessageCard(message: msg['content']);
                        } else {
                          return SentMessageCard(message: msg['content']);
                        }
                      },
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                height: 55,
                width: 500,
                child: SizedBox(
                    child: Row(
                  children: [
                    SizedBox(width: 30),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: msgController,
                        decoration: InputDecoration(border: InputBorder.none),
                        cursorHeight: 30,
                        cursorColor: mainRedColor,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (msgController.text != null &&
                              msgController.text != '') {
                            try {
                              print('sent msg calling..');
                              sentMsg();
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: mainRedColor,
                        ))
                  ],
                )),
              ),
            ),
          ],
        ));
  }

  sentMsg() async {
    User? user = FirebaseAuth.instance.currentUser;

    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Users');
// freind uid -> user id
    Map<String, dynamic> jsonData = {
      '${currentUser?.uid}': FieldValue.arrayUnion([
        {'content': '${msgController.text}', 'isRecieved': true, 'time': 500}
      ]),
    };
    DocumentReference documentReference =
        collectionReference.doc('${widget.friend.friendId}');
    var a = await documentReference.get();
    if (a.exists) {
      documentReference.update(jsonData);
    } else {
      documentReference.set(jsonData);
    }
// user uid -> friend -> uid
    jsonData = {
      '${widget.friend.friendId}': FieldValue.arrayUnion([
        {'content': '${msgController.text}', 'isRecieved': false, 'time': 500}
      ]),
    };
    print(jsonData);
    documentReference = collectionReference.doc('${currentUser?.uid}');
    a = await documentReference.get();
    if (a.exists) {
      documentReference.update(jsonData);
      msgController.text = '';
    } else {
      documentReference.set(jsonData);
      msgController.text = '';
    }
  }
}
