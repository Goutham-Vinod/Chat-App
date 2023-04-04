import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RecieveMessageCard extends StatelessWidget {
  RecieveMessageCard({required this.message, this.dpImage, super.key});
  Image? dpImage;
  String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25),
      child: Row(
        children: [
          dpImage ?? Image.asset('assets/default_dp.png', width: 40),
          SizedBox(width: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('$message'),
            ),
          ),
        ],
      ),
    );
  }
}
