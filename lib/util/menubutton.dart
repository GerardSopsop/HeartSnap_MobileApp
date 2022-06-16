import "package:flutter/material.dart";

import '../diary/diary.dart';
import '../heart/heart.dart';
import '../snap/choose.dart';

class MenuButton extends StatelessWidget {
  const MenuButton(
      {Key? key,
      required this.text,
      required this.name,
      required this.img,
      required this.side})
      : super(key: key);
  final String text, name;
  final bool side;
  final Map<String, dynamic> img;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(left: side ? 60 : 0, right: side ? 0 : 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
            splashFactory: NoSplash.splashFactory,
            primary: const Color.fromRGBO(242, 193, 113, 1),
            shadowColor: Colors.transparent),
        child: Text(
          text,
          textAlign: side ? TextAlign.right : TextAlign.left,
          style: const TextStyle(fontFamily: "Lucidity-Expand", fontSize: 15),
        ),
        onPressed: () async {
          dynamic page;
          if (text == "TAKE A\nSNAP") {
            page = ChooseTool(img: img, user: name);
          } else if (text == "FOOD\nDIARY") {
            page = Diary(
              user: name,
              img: img,
            );
          } else {
            page = Heart(img: img);
          }

          final pageNext = await Future.microtask(() {
            return page;
          });
          final route = MaterialPageRoute(builder: (_) => pageNext);
          Navigator.push(context, route);
        },
      ),
    );
  }
}
