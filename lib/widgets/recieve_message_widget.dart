import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RecieveMessageCard extends StatelessWidget {
  RecieveMessageCard({required this.message, this.dpUrl, super.key});
  String? dpUrl;
  String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: dpUrl != null
                    ? DecorationImage(
                        image: NetworkImage(dpUrl!), fit: BoxFit.cover)
                    : DecorationImage(
                        image: AssetImage('assets/default_dp.png'),
                        fit: BoxFit.cover)),
          ),
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
