import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/snap/senddata.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../database/addfood.dart';
import 'foodinfo.dart';

class BarcodePreview extends StatefulWidget {
  const BarcodePreview(
      {Key? key, required this.img, required this.user, required this.camera})
      : super(key: key);
  final Map<String, dynamic> img;
  final String user;
  final CameraDescription camera;
  @override
  State<BarcodePreview> createState() => _BarcodePreviewState();
}

class _BarcodePreviewState extends State<BarcodePreview>
    with WidgetsBindingObserver {
  late CameraController controller;
  late MobileScanner scanner;
  String barNum = "";
  bool _free = true;

  TextEditingController image = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController kcal = TextEditingController();
  TextEditingController trans = TextEditingController();
  TextEditingController sat = TextEditingController();
  TextEditingController omega = TextEditingController();
  TextEditingController chol = TextEditingController();
  TextEditingController sod = TextEditingController();
  TextEditingController fib = TextEditingController();
  TextEditingController alc = TextEditingController();

  ValueNotifier<String> found = ValueNotifier("");
  ValueNotifier<bool> cam = ValueNotifier(false);
  ValueNotifier<bool> prev = ValueNotifier(false);

  Future<void> getScanner() async {
    scanner = MobileScanner(
        controller: MobileScannerController(),
        allowDuplicates: false,
        onDetect: (barcode, args) async {
          if (barcode.rawValue == null) {
            name.text = 'Failed to scan Barcode';
            found.value = "";
          } else {
            barNum = barcode.rawValue!;
            final Map<String, dynamic> code = await uploadBarcode(barNum);
            if (code["status"]) {
              name.text = code["name"];
              kcal.text = '${code["kcal"]}';
              sat.text = '${code["saturated"]}';
              trans.text = '${code["trans"]}';
              omega.text = '${code["omega"]}';
              fib.text = '${code["fiber"]}';
              chol.text = '${code["cholesterol"]}';
              alc.text = '${code["alcohol"]}';
              sod.text = '${code["sodium"]}';
              found.value = barNum;
            } else {
              name.text = "Product not found";
              kcal.clear();
              sat.clear();
              trans.clear();
              omega.clear();
              fib.clear();
              chol.clear();
              alc.clear();
              sod.clear();
              found.value = "";
            }
          }
        });
  }

  Future<void> getCamera() async {
    controller = CameraController(widget.camera, ResolutionPreset.medium);
    await controller.initialize();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (cam.value) {
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
  }

  @override
  void dispose() {
    if (cam.value) controller.dispose();
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
                          child: ValueListenableBuilder(
                        valueListenable: cam,
                        builder:
                            (BuildContext context, bool val, Widget? child) {
                          return val
                              ? FutureBuilder(
                                  future: getCamera(),
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
                                  })
                              : FutureBuilder(
                                  future: getScanner(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return scanner;
                                    }
                                    return Container();
                                  },
                                );
                        },
                      ))),
                )),
            const Padding(padding: EdgeInsets.only(bottom: 5)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: ValueListenableBuilder(
                  valueListenable: found,
                  builder: (BuildContext context, String val, Widget? child) {
                    return FoodInfo(
                        name: name,
                        kcal: kcal,
                        sat: sat,
                        trans: trans,
                        omega: omega,
                        fib: fib,
                        chol: chol,
                        alc: alc,
                        sod: sod);
                  }),
            ),
            SizedBox(
                child: ValueListenableBuilder(
              valueListenable: cam,
              builder: (BuildContext context, bool tool, Widget? child) {
                return tool
                    ? ValueListenableBuilder(
                        valueListenable: prev,
                        builder:
                            (BuildContext context, bool val, Widget? child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                  elevation: 0,
                                  backgroundColor: _free && !val
                                      ? Colors.green[500]
                                      : Colors.grey,
                                  onPressed: _free && !val
                                      ? () async {
                                          _free = false;
                                          try {
                                            controller
                                                .setFlashMode(FlashMode.off);
                                            final XFile file =
                                                await controller.takePicture();
                                            image.text = file.path;
                                            prev.value = true;
                                            _free = true;
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
                                  heroTag: 1,
                                  elevation: 0,
                                  backgroundColor: val
                                      ? const Color.fromRGBO(152, 206, 111, 1)
                                      : Colors.grey,
                                  onPressed: val
                                      ? () async {
                                          final String whole =
                                              DateTime.now().toString();
                                          final String time = DateFormat.jm()
                                              .format(DateFormat("hh:mm:ss")
                                                  .parse(
                                                      whole.substring(11, 19)));
                                          final String date =
                                              DateFormat.yMMMMd()
                                                  .format(DateTime.now());
                                          await addFood({
                                            "name": name.text,
                                            "path": image.text,
                                            "kcal": kcal.text == "-"
                                                ? 0
                                                : double.parse(kcal.text),
                                            "trans": trans.text == "-"
                                                ? 0
                                                : double.parse(trans.text),
                                            "omega": omega.text == "-"
                                                ? 0
                                                : double.parse(omega.text),
                                            "saturated": sat.text == "-"
                                                ? 0
                                                : double.parse(sat.text),
                                            "cholesterol": chol.text == "-"
                                                ? 0
                                                : double.parse(chol.text),
                                            "sodium": sod.text == "-"
                                                ? 0
                                                : double.parse(sod.text),
                                            "fiber": fib.text == "-"
                                                ? 0
                                                : double.parse(fib.text),
                                            "alcohol": alc.text == "-"
                                                ? 0
                                                : double.parse(alc.text),
                                            "date": date,
                                            "time": time
                                          }, widget.user);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            content: Text(
                                                "'${name.text}' was added to diary"),
                                          ));
                                          await controller.dispose();
                                          barNum = "";
                                          name.clear();
                                          image.clear();
                                          kcal.clear();
                                          sat.clear();
                                          trans.clear();
                                          omega.clear();
                                          fib.clear();
                                          chol.clear();
                                          alc.clear();
                                          sod.clear();
                                          cam.value = false;
                                          prev.value = false;
                                          found.value = "";
                                        }
                                      : null,
                                  child: const Icon(
                                    Icons.check,
                                    size: 40,
                                  )),
                              const Padding(padding: EdgeInsets.only(left: 20)),
                              FloatingActionButton(
                                  heroTag: 2,
                                  elevation: 0,
                                  backgroundColor:
                                      const Color.fromRGBO(240, 136, 151, 1),
                                  onPressed: !val
                                      ? () async {
                                          await controller.dispose();
                                          barNum = "";
                                          name.clear();
                                          image.clear();
                                          kcal.clear();
                                          sat.clear();
                                          trans.clear();
                                          omega.clear();
                                          fib.clear();
                                          chol.clear();
                                          alc.clear();
                                          sod.clear();
                                          cam.value = false;
                                          prev.value = false;
                                          found.value = "";
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
                        })
                    : ValueListenableBuilder(
                        valueListenable: found,
                        builder:
                            (BuildContext context, String val, Widget? child) {
                          return FloatingActionButton(
                              heroTag: 3,
                              elevation: 0,
                              backgroundColor: val != ""
                                  ? const Color.fromRGBO(152, 206, 111, 1)
                                  : Colors.grey,
                              onPressed: val != ""
                                  ? () async {
                                      scanner.controller!.dispose();
                                      cam.value = true;
                                    }
                                  : null,
                              child: const Icon(
                                Icons.add,
                                size: 40,
                              ));
                        });
              },
            ))
          ],
        )
      ]),
    );
  }
}
