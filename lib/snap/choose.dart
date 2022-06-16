import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/snap/barcode.dart';
import 'package:heartsnap_monorepo/snap/chooseitem.dart';
import 'package:heartsnap_monorepo/snap/manual.dart';
import 'package:heartsnap_monorepo/snap/preview.dart';
import 'package:heartsnap_monorepo/snap/senddata.dart';

class ChooseTool extends StatefulWidget {
  const ChooseTool({Key? key, required this.user, required this.img})
      : super(key: key);

  final String user;
  final Map<String, dynamic> img;
  @override
  State<ChooseTool> createState() => _ChooseToolState();
}

class _ChooseToolState extends State<ChooseTool> {
  TextEditingController food = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            bottom: -30,
            right: -50,
            child: widget.img["cambg1"],
          ),
          Positioned(child: widget.img["cambg2"], top: 0, left: -50),
          Column(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 100)),
              const Text(
                "CHOOSE INPUT METHOD",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Lucidity-Expand",
                    fontSize: 20,
                    color: Color.fromRGBO(152, 206, 111, 1)),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 25)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      final List<CameraDescription> camera =
                          await availableCameras();
                      final pageNext = await Future.microtask(() {
                        return Preview(
                            img: widget.img,
                            user: widget.user,
                            camera: camera[0]);
                      });
                      final route = MaterialPageRoute(builder: (_) => pageNext);
                      Navigator.push(context, route);
                    },
                    child: ChooseItem(
                      type: 1,
                      img: widget.img,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  GestureDetector(
                    onTap: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      final List<CameraDescription> camera =
                          await availableCameras();
                      final pageNext = await Future.microtask(() {
                        return BarcodePreview(
                            camera: camera[0],
                            img: widget.img,
                            user: widget.user);
                      });
                      final route = MaterialPageRoute(builder: (_) => pageNext);
                      Navigator.push(context, route);
                    },
                    child: ChooseItem(type: 2, img: widget.img),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              const Text(
                "Manual food search",
                style: TextStyle(
                    fontFamily: "DMSans",
                    fontSize: 20,
                    color: Color.fromRGBO(152, 206, 111, 1)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextField(
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
                      hintText: "Food name",
                      fillColor: Colors.grey[200]),
                  controller: food,
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: food,
                  builder: (BuildContext context, TextEditingValue val,
                      Widget? child) {
                    return TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: val.text.isEmpty
                              ? Colors.green[50]
                              : Colors.green,
                          onSurface: Colors.grey,
                        ),
                        onPressed: val.text.isEmpty
                            ? null
                            : () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Map<String, dynamic> infos =
                                    await uploadName(val.text);
                                final List<CameraDescription> camera =
                                    await availableCameras();
                                final pageNext = await Future.microtask(() {
                                  return ManualSearch(
                                      infos: infos,
                                      name: val.text,
                                      camera: camera[0],
                                      img: widget.img,
                                      user: widget.user);
                                });
                                final route =
                                    MaterialPageRoute(builder: (_) => pageNext);
                                Navigator.push(context, route)
                                    .then((value) => food.clear());
                              },
                        child: const Text("Search"));
                  }),
            ],
          )
        ],
      ),
    );
  }
}
