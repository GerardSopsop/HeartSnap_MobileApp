import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/menu/menuitem.dart';
import 'package:heartsnap_monorepo/util/logo.dart';
import 'package:heartsnap_monorepo/util/settingsbutton.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key, required this.img, required this.name})
      : super(key: key);
  final Map<String, dynamic> img;
  final String name;

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final double top = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(children: [
          Positioned(
            child: widget.img["menubg"],
            top: top,
            left: -50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Logo(
                  img: widget.img,
                ),
                const Text(
                  "MENU",
                  style: TextStyle(
                      fontFamily: "Lucidity-Condensed",
                      fontSize: 60,
                      color: Color.fromRGBO(152, 206, 111, 1)),
                ),
                const Divider(
                  color: Color.fromRGBO(152, 206, 111, 1),
                  thickness: 2,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                ItemMenu(
                    img: widget.img,
                    label: "TAKE A\nSNAP",
                    name: widget.name,
                    side: false),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                ItemMenu(
                    img: widget.img,
                    name: widget.name,
                    label: "FOOD\nDIARY",
                    side: true),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                ItemMenu(
                    img: widget.img,
                    name: widget.name,
                    label: "ABOUT\nTHE\nHEART",
                    side: false),
              ],
            ),
          ),
          Positioned(child: widget.img["menubg"], bottom: -60, right: -10),
          Positioned(
            child: SettingsButton(user: widget.name),
            top: top,
            right: 0,
          )
        ]),
      ),
    );
  }
}
