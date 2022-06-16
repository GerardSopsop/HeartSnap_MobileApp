import 'package:flutter/material.dart';

class FoodName extends StatelessWidget {
  const FoodName({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontFamily: "DMSans", color: Colors.white),
      decoration: const InputDecoration(
          contentPadding:
              EdgeInsets.only(bottom: 10, left: 8, top: 7, right: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
          isDense: true,
          filled: true,
          fillColor: Color.fromRGBO(240, 136, 151, 1)),
      controller: controller,
      readOnly: true,
      textAlign: TextAlign.center,
    );
  }
}
