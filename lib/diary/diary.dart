import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/diary/fooddates.dart';
import 'package:heartsnap_monorepo/util/logo.dart';

class Diary extends StatefulWidget {
  const Diary({Key? key, required this.user, required this.img})
      : super(key: key);
  final String user;
  final Map<String, dynamic> img;
  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          bottom: -50,
          right: -30,
          child: widget.img["listbg"],
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, bottom: 5),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Logo(img: widget.img)),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              const Text(
                "FOOD DIARY",
                style: TextStyle(
                    fontFamily: "Lucidity-Expand",
                    color: Color.fromRGBO(152, 206, 111, 1),
                    fontSize: 20),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              FoodDate(user: widget.user, img: widget.img)
            ],
          ),
        )
      ]),
    );
  }
}
