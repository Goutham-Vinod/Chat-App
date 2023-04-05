import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {this.title,
      this.subtitle,
      this.onTapFunction,
      this.unReadMsgCount,
      this.dpUrl,
      super.key});
  String? title, subtitle;

  Function? onTapFunction;

  int? unReadMsgCount;

  String? dpUrl;

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
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: AssetImage('assets/default_dp.png'),
                              fit: BoxFit.cover)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: dpUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(dpUrl!),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: AssetImage('assets/default_dp.png'),
                                    fit: BoxFit.cover)),
                      ),
                    )),
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
