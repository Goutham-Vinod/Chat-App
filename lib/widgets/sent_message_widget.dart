import 'package:chat_app/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SentMessageCard extends StatelessWidget {
  SentMessageCard({required this.message, this.dpImage, super.key});
  Image? dpImage;
  String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25),
      child: Row(
        children: [
          Spacer(),
          SizedBox(width: 20),
          Container(
            decoration: BoxDecoration(
              color: mainRedColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.zero,
                  bottomLeft: Radius.circular(15)),
            ),
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '$message',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
