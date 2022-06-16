import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, required this.img}) : super(key: key);
  final Map<String, dynamic> img;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: img["logo2"],
          ),
          SizedBox(
            width: 200,
            child: img["logo1"],
          ),
        ],
      ),
    );
  }
}
