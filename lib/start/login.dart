import 'package:flutter/material.dart';

import '../database/findacc.dart';
import '../menu/menu.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key, required this.img}) : super(key: key);
  final Map<String, dynamic> img;
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController login = TextEditingController();

  @override
  void dispose() {
    login.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.img["logo"]!,
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              const Text(
                "WELCOME BACK",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Lucidity-Expand",
                    color: Color.fromRGBO(152, 206, 111, 1)),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                decoration: InputDecoration(
                    filled: true,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(width: 2, color: Colors.green),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent),
                    ),
                    contentPadding: const EdgeInsets.only(
                        bottom: 10, left: 8, top: 7, right: 8),
                    isDense: true,
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 15),
                    hintText: "Name",
                    fillColor: Colors.grey[200]),
                keyboardType: TextInputType.name,
                controller: login,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              SizedBox(
                width: width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      splashFactory: NoSplash.splashFactory,
                      primary: const Color.fromRGBO(152, 206, 111, 1),
                      shadowColor: Colors.transparent),
                  child: const Text(
                    "Log in",
                    style: TextStyle(fontFamily: "DMSans"),
                  ),
                  onPressed: login.text != ""
                      ? () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final String findAcc =
                              (await findAccount(login.text))["name"];
                          if (findAcc == "") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("USER NOT FOUND"),
                            ));
                          } else {
                            final pageNext = await Future.microtask(() {
                              return Menu(img: widget.img, name: findAcc);
                            });
                            final route =
                                MaterialPageRoute(builder: (_) => pageNext);
                            Navigator.push(context, route);
                          }
                        }
                      : null,
                ),
              )
            ],
          ),
        ));
  }
}
