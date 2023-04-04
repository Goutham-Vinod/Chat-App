import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {this.title,
      this.subtitle,
      this.image,
      this.onTapFunction,
      this.unReadMsgCount,
      super.key});
  String? title, subtitle;

  Image? image;

  Function? onTapFunction;

  int? unReadMsgCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          if (onTapFunction != null) {
            onTapFunction!();
          }
        },
        child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child:
                      image ?? Image.asset('assets/default_dp.png', width: 60),
                ),
                SizedBox(width: 30),
                SizedBox(
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '$title',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('$subtitle'),
                    ],
                  ),
                ),
                Spacer(),
                unReadMsgCount != null
                    ? Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(153, 187, 187, 187),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            unReadMsgCount.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ))
                    : Text(''),
                SizedBox(width: 30),
              ],
            )),
      ),
    );
  }
}
