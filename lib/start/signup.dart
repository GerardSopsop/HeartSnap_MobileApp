import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/start/disease.dart';
import 'package:heartsnap_monorepo/util/button.dart';
import 'package:heartsnap_monorepo/util/textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, required this.img}) : super(key: key);
  final Map<String, dynamic> img;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController calorie = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.img["logo"]!,
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              const Text(
                "PLEASE PROVIDE SOME PERSONAL INFORMATION",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Lucidity-Expand",
                    color: Color.fromRGBO(152, 206, 111, 1)),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextInput(
                  label: "Name", controller: name, type: TextInputType.name),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              TextInput(
                  label: "Sex: (Male/Female)",
                  controller: sex,
                  type: TextInputType.name),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              TextInput(
                  label: "Height: (cm)",
                  controller: height,
                  type: TextInputType.number),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              TextInput(
                  label: "Weight: (kg)",
                  controller: weight,
                  type: TextInputType.number),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              TextInput(
                  label: "Daily calorie goal: (kcal)",
                  controller: calorie,
                  type: TextInputType.number),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Button(
                text: "Sign up",
                name: name.text,
                sex: sex.text.toUpperCase(),
                page: Disease(
                  img: widget.img,
                  infos: {
                    "name": name.text,
                    "calorie": calorie.text,
                    "sex": sex.text.toUpperCase(),
                    "height": height.text,
                    "weight": weight.text
                  },
                ),
                enabled: name.text != "" &&
                    calorie.text != "" &&
                    sex.text != "" &&
                    height.text != "" &&
                    weight.text != "",
              )
            ],
          ),
        ));
  }
}
