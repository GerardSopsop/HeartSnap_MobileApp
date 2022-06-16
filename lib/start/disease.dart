import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/infographics/base.dart';

class Disease extends StatefulWidget {
  const Disease({Key? key, required this.img, required this.infos})
      : super(key: key);
  final Map<String, dynamic> img, infos;

  @override
  State<Disease> createState() => _DiseaseState();
}

class _DiseaseState extends State<Disease> {
  @override
  Widget build(BuildContext context) {
    final double w = double.parse(widget.infos["weight"]);
    final double h = double.parse(widget.infos["height"]) / 100;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: MediaQuery.of(context).padding.top),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.img["logo"]!,
              const Padding(padding: EdgeInsets.only(bottom: 30)),
              const Text(
                "ARE YOU IN A RISK OF A CARDIOVASCULAR DISEASE?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Lucidity-Expand",
                    color: Color.fromRGBO(152, 206, 111, 1)),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            splashFactory: NoSplash.splashFactory,
                            primary: const Color.fromRGBO(240, 136, 151, 1),
                            shadowColor: Colors.transparent),
                        child: const Text(
                          "YES",
                          style: TextStyle(fontFamily: "DMSans"),
                        ),
                        onPressed: () async {
                          widget.infos["disease"] = "YES";
                          final pageNext = await Future.microtask(() {
                            return InfoGraphics(
                                img: widget.img, infos: widget.infos);
                          });
                          final route =
                              MaterialPageRoute(builder: (_) => pageNext);
                          Navigator.push(context, route);
                        },
                      )),
                  const Padding(padding: EdgeInsets.only(right: 50)),
                  SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            splashFactory: NoSplash.splashFactory,
                            primary: const Color.fromRGBO(152, 206, 111, 1),
                            shadowColor: Colors.transparent),
                        child: const Text(
                          "NO",
                          style: TextStyle(fontFamily: "DMSans"),
                        ),
                        onPressed: () async {
                          final bmi = w / (h * h);
                          if (bmi > 25 || bmi < 20) {
                            widget.infos["disease"] = "YES";
                          } else {
                            widget.infos["disease"] = "NO";
                          }
                          final pageNext = await Future.microtask(() {
                            return InfoGraphics(
                                img: widget.img, infos: widget.infos);
                          });
                          final route =
                              MaterialPageRoute(builder: (_) => pageNext);
                          Navigator.push(context, route);
                        },
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
