import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/util/foodfacts.dart';
import 'package:heartsnap_monorepo/util/foodname.dart';

class FoodInfo extends StatefulWidget {
  const FoodInfo(
      {Key? key,
      required this.name,
      required this.kcal,
      required this.trans,
      required this.sat,
      required this.omega,
      required this.chol,
      required this.fib,
      required this.sod,
      required this.alc})
      : super(key: key);
  final TextEditingController name;
  final TextEditingController kcal;
  final TextEditingController trans;
  final TextEditingController sat;
  final TextEditingController omega;
  final TextEditingController chol;
  final TextEditingController sod;
  final TextEditingController fib;
  final TextEditingController alc;
  @override
  State<FoodInfo> createState() => _FoodInfoState();
}

class _FoodInfoState extends State<FoodInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FoodName(
          controller: widget.name,
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        FoodFacts(
          controller: widget.kcal,
          label: "Energy calculated (kcal)",
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2)),
        FoodFacts(
          controller: widget.sat,
          label: "Saturated Fat (g)",
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2)),
        FoodFacts(
          controller: widget.omega,
          label: "Healthy Fat (g)",
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2)),
        FoodFacts(
          controller: widget.chol,
          label: "Cholesterol (mg)",
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2)),
        FoodFacts(
          controller: widget.sod,
          label: "Sodium (mg)",
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2)),
        FoodFacts(
          controller: widget.fib,
          label: "Dietary Fiber (g)",
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2)),
        FoodFacts(
          controller: widget.alc,
          label: "Alcohol (g)",
        ),
        const Padding(padding: EdgeInsets.only(bottom: 2)),
        FoodFacts(
          controller: widget.trans,
          label: "Trans Fat (g)",
        ),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
      ],
    );
  }
}
