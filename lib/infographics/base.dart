import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/database/createacc.dart';
import 'package:heartsnap_monorepo/infographics/dots.dart';
import 'package:heartsnap_monorepo/infographics/info.dart';
import 'package:heartsnap_monorepo/menu/menu.dart';

import '../util/button.dart';

class InfoGraphics extends StatefulWidget {
  const InfoGraphics({Key? key, required this.img, required this.infos})
      : super(key: key);
  final Map<String, dynamic> img, infos;
  @override
  State<InfoGraphics> createState() => _InfoGraphicsState();
}

class _InfoGraphicsState extends State<InfoGraphics> {
  ValueNotifier<double> pageNum = ValueNotifier(0);
  ValueNotifier<bool> done = ValueNotifier(false);
  final PageController page = PageController();

  @override
  void initState() {
    super.initState();
    createAccount(widget.infos);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(children: [
          Positioned(
            child: widget.img["infobg"],
            left: -250,
            top: MediaQuery.of(context).padding.top,
          ),
          PageView(
            controller: page,
            onPageChanged: (val) {
              pageNum.value = val * 1.0;
              if (val == 4) {
                done.value = true;
              }
            },
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                widget.img["logo"],
                const Padding(padding: EdgeInsets.only(bottom: 50)),
                const Text(
                  "Welcome!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "DMSans",
                      fontSize: 40,
                      color: Color.fromRGBO(152, 206, 111, 1)),
                )
              ]),
              Info(
                  image: widget.img["info1"]!,
                  text: "SNAP",
                  info:
                      "Take a snap of your food and let our AI identify the food and it's nutrients"),
              Info(
                image: widget.img["info2"]!,
                text: "RECORD",
                info: "Automatically record the food that you eat",
              ),
              Info(
                image: widget.img["info3"]!,
                text: "TRACK",
                info: "Track nutrients relevant to your heart's health",
              ),
              Info(
                  image: widget.img["info4"]!,
                  text: "EXPLORE",
                  info:
                      "Explore our app and learn more about how to take care of your heart")
            ],
          ),
          Positioned(
              bottom: 130,
              left: 0,
              right: 0,
              child: InfoDots(
                val: pageNum,
              )),
          Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: ValueListenableBuilder(
                valueListenable: done,
                builder: (BuildContext context, bool val, Widget? child) {
                  return Button(
                    enabled: val,
                    page: Menu(img: widget.img, name: widget.infos["name"]),
                    text: "CONTINUE",
                  );
                },
              ))
        ]),
      ),
    );
  }
}
