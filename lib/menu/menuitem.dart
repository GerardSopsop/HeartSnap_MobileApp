import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/diary/diary.dart';
import 'package:heartsnap_monorepo/heart/heart.dart';
import 'package:heartsnap_monorepo/snap/choose.dart';
import 'package:heartsnap_monorepo/util/menubutton.dart';

class ItemMenu extends StatelessWidget {
  const ItemMenu(
      {Key? key,
      required this.name,
      required this.img,
      required this.label,
      required this.side})
      : super(key: key);
  final Map<String, dynamic> img;
  final String label, name;
  final bool side;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 120,
      child: Stack(children: [
        Positioned(
            top: 10,
            right: side ? 50 : 0,
            left: side ? 0 : 50,
            child: MenuButton(text: label, side: !side, img: img, name: name)),
        Positioned(
          left: side ? 130 : 0,
          child: GestureDetector(
            onTap: () async {
              dynamic page;
              if (label == "TAKE A\nSNAP") {
                page = ChooseTool(img: img, user: name);
              } else if (label == "FOOD\nDIARY") {
                page = Diary(user: name, img: img);
              } else {
                page = Heart(img: img);
              }
              final pageNext = await Future.microtask(() {
                return page;
              });
              final route = MaterialPageRoute(builder: (_) => pageNext);
              Navigator.push(context, route);
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage: label == "TAKE A\nSNAP"
                  ? img["menu1"]
                  : label == "FOOD\nDIARY"
                      ? img["menu2"]
                      : img["menu3"],
            ),
          ),
        ),
      ]),
    );
  }
}
