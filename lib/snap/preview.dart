import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/snap/foodinfo.dart';
import 'package:heartsnap_monorepo/snap/senddata.dart';
import 'package:heartsnap_monorepo/util/textfield.dart';
import 'package:intl/intl.dart';

import '../database/addfood.dart';
import 'camera.dart';

class Preview extends StatefulWidget {
  const Preview(
      {Key? key, required this.img, required this.user, required this.camera})
      : super(key: key);
  final String user;
  final Map<String, dynamic> img;
  final CameraDescription camera;
  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> with WidgetsBindingObserver {
  late CameraController controller;
  late Future<void> initializeControllerFuture;

  TextEditingController name = TextEditingController();
  TextEditingController kcal = TextEditingController();
  TextEditingController trans = TextEditingController();
  TextEditingController sat = TextEditingController();
  TextEditingController omega = TextEditingController();
  TextEditingController chol = TextEditingController();
  TextEditingController sod = TextEditingController();
  TextEditingController fib = TextEditingController();
  TextEditingController alc = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController quantity = TextEditingController()..text = "100";

  ValueNotifier<bool> prev = ValueNotifier(false);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
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
          initializeControllerFuture = controller.initialize();
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
    bool _free = true;
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                SizedBox(
                    width: size.width - 60,
                    height: size.width - 60,
                    child: FutureBuilder(
                        future: initializeControllerFuture,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Camera(
                                camera: controller.value,
                                state: prev,
                                image: image,
                                controller: controller);
                          }
                          return Container();
                        })),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                ValueListenableBuilder(
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
                const Padding(padding: EdgeInsets.only(bottom: 5)),
                FoodInfo(
                    name: name,
                    kcal: kcal,
                    sat: sat,
                    trans: trans,
                    omega: omega,
                    fib: fib,
                    chol: chol,
                    alc: alc,
                    sod: sod),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                SizedBox(
                    child: ValueListenableBuilder(
                        valueListenable: prev,
                        builder:
                            (BuildContext context, bool val, Widget? child) {
                          if (val) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                    heroTag: 7,
                                    elevation: 0,
                                    backgroundColor:
                                        const Color.fromRGBO(152, 206, 111, 1),
                                    onPressed: () async {
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
                                        "name": name.text,
                                        "path": image.text,
                                        "kcal": kcal.text == "-"
                                            ? 0
                                            : value * double.parse(kcal.text),
                                        "trans": trans.text == "-"
                                            ? 0
                                            : value * double.parse(trans.text),
                                        "omega": omega.text == "-"
                                            ? 0
                                            : value * double.parse(omega.text),
                                        "saturated": sat.text == "-"
                                            ? 0
                                            : value * double.parse(sat.text),
                                        "cholesterol": chol.text == "-"
                                            ? 0
                                            : value * double.parse(chol.text),
                                        "sodium": sod.text == "-"
                                            ? 0
                                            : value * double.parse(sod.text),
                                        "fiber": fib.text == "-"
                                            ? 0
                                            : value * double.parse(fib.text),
                                        "alcohol": alc.text == "-"
                                            ? 0
                                            : value * double.parse(alc.text),
                                        "date": date,
                                        "time": time
                                      }, widget.user);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text(
                                            "'${name.text}' was added to diary"),
                                      ));
                                      prev.value = false;
                                      name.clear();
                                      kcal.clear();
                                      sat.clear();
                                      trans.clear();
                                      omega.clear();
                                      fib.clear();
                                      chol.clear();
                                      alc.clear();
                                      sod.clear();
                                      image.clear();
                                    },
                                    child: const Icon(
                                      Icons.check,
                                      size: 40,
                                    )),
                                const Padding(
                                    padding: EdgeInsets.only(left: 20)),
                                FloatingActionButton(
                                    heroTag: 8,
                                    elevation: 0,
                                    backgroundColor:
                                        const Color.fromRGBO(240, 136, 151, 1),
                                    onPressed: () async {
                                      prev.value = false;
                                      name.clear();
                                      kcal.clear();
                                      sat.clear();
                                      trans.clear();
                                      omega.clear();
                                      fib.clear();
                                      chol.clear();
                                      alc.clear();
                                      sod.clear();
                                      image.clear();
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      size: 40,
                                    ))
                              ],
                            );
                          }
                          return FloatingActionButton(
                              heroTag: 9,
                              elevation: 0,
                              backgroundColor:
                                  _free ? Colors.green[500] : Colors.grey,
                              onPressed: _free
                                  ? () async {
                                      _free = false;
                                      try {
                                        controller.setFlashMode(FlashMode.off);
                                        final XFile file =
                                            await controller.takePicture();
                                        image.text = file.path;
                                        Map<String, dynamic> infos =
                                            await uploadImage(file.path);
                                        name.text = infos["name"];
                                        kcal.text = '${infos["kcal"]}';
                                        sat.text = '${infos["saturated"]}';
                                        trans.text = '${infos["trans"]}';
                                        omega.text = '${infos["omega"]}';
                                        fib.text = '${infos["fiber"]}';
                                        chol.text = '${infos["cholesterol"]}';
                                        alc.text = '${infos["alcohol"]}';
                                        sod.text = '${infos["sodium"]}';
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
                              ));
                        })),
              ],
            ),
          )
        ],
      ),
    );
  }
}
