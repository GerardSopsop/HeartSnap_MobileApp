import "package:flutter/material.dart";
import 'package:heartsnap_monorepo/database/findacc.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.text,
      required this.page,
      required this.enabled,
      this.sex = "",
      this.name = ""})
      : super(key: key);
  final String text, name, sex;
  final dynamic page;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            splashFactory: NoSplash.splashFactory,
            primary: const Color.fromRGBO(152, 206, 111, 1),
            shadowColor: Colors.transparent),
        child: Text(
          text,
          style: const TextStyle(fontFamily: "DMSans"),
        ),
        onPressed: enabled
            ? () async {
                FocusManager.instance.primaryFocus?.unfocus();
                final validCharacters = RegExp(r'^[a-zA-Z]+$');
                if (text == "Sign up") {
                  if (!validCharacters.hasMatch(name)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("INVALID NAME, USE LETTERS ONLY"),
                    ));
                  } else {
                    final String find = (await findAccount(name))["name"];

                    if (find != "") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("NAME ALREADY TAKEN"),
                      ));
                    } else if (sex != "MALE" && sex != "FEMALE") {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("INVALID SEX"),
                      ));
                    } else {
                      final pageNext = await Future.microtask(() {
                        return page;
                      });
                      final route = MaterialPageRoute(builder: (_) => pageNext);
                      Navigator.push(context, route);
                    }
                  }
                } else {
                  final pageNext = await Future.microtask(() {
                    return page;
                  });
                  final route = MaterialPageRoute(builder: (_) => pageNext);
                  Navigator.push(context, route);
                }
              }
            : null,
      ),
    );
  }
}
