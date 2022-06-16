import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../database/addfood.dart';
import '../util/textfield.dart';
import 'foodinfo.dart';

class ManualSearch extends StatefulWidget {
  const ManualSearch(
      {Key? key,
      required this.infos,
      required this.name,
      required this.user,
      required this.img,
      required this.camera})
      : super(key: key);

  final String user, name;
  final Map<String, dynamic> img, infos;
  final CameraDescription camera;
  @override
  State<ManualSearch> createState() => _ManualSearchState();
}

class _ManualSearchState extends State<ManualSearch>
    with WidgetsBindingObserver {
  late Future<void> initializeControllerFuture;
  late CameraController controller;
  bool free = true;

  TextEditingController image = TextEditingController();
  TextEditingController kcal = TextEditingController();
  TextEditingController trans = TextEditingController();
  TextEditingController sat = TextEditingController();
  TextEditingController omega = TextEditingController();
  TextEditingController chol = TextEditingController();
  TextEditingController sod = TextEditingController();
  TextEditingController fib = TextEditingController();
  TextEditingController alc = TextEditingController();
  TextEditingController quantity = TextEditingController()..text = "100";

  ValueNotifier<bool> prev = ValueNotifier(false);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.medium);
    initializeControllerFuture = controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.resumed) {
      controller = CameraController(widget.camera, ResolutionPreset.medium);

      if (mounted) {
        setState(() {
          controller.initialize();
        });
      }
    } else {
      cameraController.dispose();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned(
          bottom: -30,
          right: -50,
          child: widget.img["cambg1"],
        ),
        Positioned(child: widget.img["cambg2"], top: 0, left: -50),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: size.width - 60,
                height: size.width - 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      color: Colors.black,
                      child: Center(
                          child: FutureBuilder(
                              future: initializeControllerFuture,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ValueListenableBuilder(
                                      valueListenable: prev,
                                      builder: (BuildContext context,
                                          bool state, Widget? child) {
                                        return state
                                            ? Image.file(File(image.text))
                                            : CameraPreview(controller);
                                      });
                                }
                                return Container();
                              }))),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: ValueListenableBuilder(
                  valueListenable: prev,
                  builder: (BuildContext context, bool val, Widget? child) {
                    return TextInput(
                      label: "",
                      controller: quantity,
                      type: TextInputType.number,
                      prefix: "Amount in grams: ",
                      editable: val,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: FoodInfo(
                  name: TextEditingController()..text = widget.name,
                  kcal: TextEditingController()..text = widget.infos["kcal"],
                  sat: TextEditingController()
                    ..text = widget.infos["saturated"],
                  trans: TextEditingController()..text = widget.infos["trans"],
                  omega: TextEditingController()..text = widget.infos["omega"],
                  fib: TextEditingController()..text = widget.infos["fiber"],
                  chol: TextEditingController()
                    ..text = widget.infos["cholesterol"],
                  alc: TextEditingController()..text = widget.infos["alcohol"],
                  sod: TextEditingController()..text = widget.infos["sodium"]),
            ),
            SizedBox(
                child: ValueListenableBuilder(
                    valueListenable: prev,
                    builder: (BuildContext context, bool val, Widget? child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                              heroTag: 4,
                              elevation: 0,
                              backgroundColor: free && !val
                                  ? Colors.green[500]
                                  : Colors.grey,
                              onPressed: free && !val
                                  ? () async {
                                      free = false;
                                      try {
                                        controller.setFlashMode(FlashMode.off);
                                        final XFile file =
                                            await controller.takePicture();
                                        image.text = file.path;
                                        prev.value = true;
                                        free = true;
                                      } catch (e) {
                                        null;
                                      }
                                    }
                                  : null,
                              child: const Icon(
                                Icons.camera_alt,
                                size: 40,
                              )),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          FloatingActionButton(
                              heroTag: 5,
                              elevation: 0,
                              backgroundColor: val
                                  ? const Color.fromRGBO(152, 206, 111, 1)
                                  : Colors.grey,
                              onPressed: val
                                  ? () async {
                                      final int grams = int.parse(
                                          quantity.text.isEmpty
                                              ? "100"
                                              : quantity.text);
                                      final double value = grams / 100;
                                      final String whole =
                                          DateTime.now().toString();
                                      final String time = DateFormat.jm()
                                          .format(DateFormat("hh:mm:ss")
                                              .parse(whole.substring(11, 19)));
                                      final String date = DateFormat.yMMMMd()
                                          .format(DateTime.now());
                                      await addFood({
                                        "name": widget.name,
                                        "path": image.text,
                                        "kcal": widget.infos["kcal"] == "-"
                                            ? 0
                                            : value *
                                                double.parse(
                                                    widget.infos["kcal"]),
                                        "trans": widget.infos["trans"] == "-"
                                            ? 0
                                            : value *
                                                double.parse(
                                                    widget.infos["trans"]),
                                        "omega": widget.infos["omega"] == "-"
                                            ? 0
                                            : value *
                                                double.parse(
                                                    widget.infos["omega"]),
                                        "saturated": widget
                                                    .infos["saturated"] ==
                                                "-"
                                            ? 0
                                            : value *
                                                double.parse(
                                                    widget.infos["saturated"]),
                                        "cholesterol":
                                            widget.infos["cholesterol"] == "-"
                                                ? 0
                                                : value *
                                                    double.parse(widget
                                                        .infos["cholesterol"]),
                                        "fiber": widget.infos["fiber"] == "-"
                                            ? 0
                                            : value *
                                                double.parse(
                                                    widget.infos["fiber"]),
                                        "alcohol": widget.infos["alcohol"] ==
                                                "-"
                                            ? 0
                                            : value *
                                                double.parse(
                                                    widget.infos["alcohol"]),
                                        "sodium": widget.infos["sodium"] == "-"
                                            ? 0
                                            : value *
                                                double.parse(
                                                    widget.infos["sodium"]),
                                        "date": date,
                                        "time": time
                                      }, widget.user);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text(
                                            "'${widget.name}' was added to diary"),
                                      ));
                                      Navigator.pop(context);
                                    }
                                  : null,
                              child: const Icon(
                                Icons.check,
                                size: 40,
                              )),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          FloatingActionButton(
                              heroTag: 6,
                              elevation: 0,
                              backgroundColor:
                                  const Color.fromRGBO(240, 136, 151, 1),
                              onPressed: !val
                                  ? () async {
                                      Navigator.pop(context);
                                    }
                                  : () {
                                      image.clear();
                                      prev.value = false;
                                    },
                              child: const Icon(
                                Icons.close,
                                size: 40,
                              ))
                        ],
                      );
                    }))
          ],
        )
      ]),
    );
  }
}
