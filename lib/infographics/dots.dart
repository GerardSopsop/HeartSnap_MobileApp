import 'package:dots_indicator/dots_indicator.dart';
import "package:flutter/material.dart";

class InfoDots extends StatelessWidget {
  const InfoDots({Key? key, required this.val}) : super(key: key);
  final ValueNotifier<double> val;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: val,
        builder: (BuildContext context, double value, Widget? child) {
          return DotsIndicator(
              dotsCount: 5,
              position: value,
              decorator: DotsDecorator(
                color: Colors.grey[200]!, // Inactive color
                activeColor: const Color.fromRGBO(152, 206, 111, 1),
              ));
        });
  }
}
