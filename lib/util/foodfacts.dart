import 'package:flutter/material.dart';

class FoodFacts extends StatelessWidget {
  const FoodFacts({Key? key, required this.controller, required this.label})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 60;
    return Row(
      children: [
        SizedBox(
          width: width / 2 - 2,
          height: 20,
          child: TextField(
            readOnly: true,
            textAlign: TextAlign.center,
            decoration: InputDecoration.collapsed(
                fillColor: const Color.fromRGBO(242, 193, 113, 1),
                filled: true,
                hintText: label,
                hintStyle: const TextStyle(
                    fontFamily: "DMSans", fontSize: 12, color: Colors.white)),
          ),
        ),
        const Padding(padding: EdgeInsets.only(right: 4)),
        SizedBox(
          width: width / 2 - 2,
          height: 20,
          child: TextField(
            readOnly: true,
            textAlign: TextAlign.center,
            decoration: const InputDecoration.collapsed(
                fillColor: Color.fromRGBO(255, 200, 55, 1),
                filled: true,
                hintText: ""),
            style: const TextStyle(
                fontFamily: "DMSans", fontSize: 15, color: Colors.white),
            controller: controller,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
