import 'dart:io';

import 'package:flutter/material.dart';

class FoodDateItem extends StatefulWidget {
  const FoodDateItem({Key? key, required this.infos}) : super(key: key);
  final List<Map<String, dynamic>> infos;

  @override
  State<FoodDateItem> createState() => _FoodDateItemState();
}

class _FoodDateItemState extends State<FoodDateItem> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 60;
    return Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: widget.infos.length == 1
              ? null
              : DecorationImage(
                  image: FileImage(File(widget.infos[1]["path"])),
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
                widget.infos[0]["date"],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    shadows: [
                      Shadow(color: Colors.black, blurRadius: 10),
                    ]),
              )
            ],
          ),
        ));
  }
}
