import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/snap/foodinfo.dart';

class FoodListItem extends StatefulWidget {
  const FoodListItem({Key? key, required this.infos, required this.index})
      : super(key: key);
  final List<Map<String, dynamic>> infos;
  final int index;
  @override
  State<FoodListItem> createState() => _FoodListItemState();
}

class _FoodListItemState extends State<FoodListItem> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 60;
    final String path = widget.infos[widget.index]["path"];
    final String time = widget.infos[widget.index]["time"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          path != ""
              ? Container(
                  height: width,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: widget.infos.length == 1
                        ? null
                        : DecorationImage(
                            image: FileImage(File(path)),
                            fit: BoxFit.fitWidth,
                          ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SizedBox(
                    width: width / 2,
                    height: width / 1.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          time,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 10),
                              ]),
                        )
                      ],
                    ),
                  ))
              : Container(),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          FoodInfo(
              name: TextEditingController()
                ..text = '${widget.infos[widget.index]["name"]}',
              kcal: TextEditingController()
                ..text = '${widget.infos[widget.index]["kcal"]}',
              trans: TextEditingController()
                ..text = '${widget.infos[widget.index]["trans"]}',
              sat: TextEditingController()
                ..text = '${widget.infos[widget.index]["saturated"]}',
              omega: TextEditingController()
                ..text = '${widget.infos[widget.index]["omega"]}',
              chol: TextEditingController()
                ..text = '${widget.infos[widget.index]["cholesterol"]}',
              fib: TextEditingController()
                ..text = '${widget.infos[widget.index]["fiber"]}',
              sod: TextEditingController()
                ..text = '${widget.infos[widget.index]["sodium"]}',
              alc: TextEditingController()
                ..text = '${widget.infos[widget.index]["alcohol"]}'),
          const Divider(
            color: Colors.green,
            thickness: 2,
          )
        ],
      ),
    );
  }
}
