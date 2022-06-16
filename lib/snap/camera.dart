import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  const Camera(
      {Key? key,
      required this.camera,
      required this.state,
      required this.image,
      required this.controller})
      : super(key: key);
  final CameraValue camera;
  final ValueNotifier<bool> state;
  final TextEditingController image;
  final CameraController controller;
  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double scale = size.aspectRatio * widget.camera.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.black,
          child: Transform.scale(
            scale: scale,
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: widget.state,
                builder: (BuildContext context, bool val, Widget? child) {
                  if (val) {
                    return Image.file(File(widget.image.text));
                  }
                  return CameraPreview(widget.controller);
                },
              ),
            ),
          ),
        ));
  }
}
