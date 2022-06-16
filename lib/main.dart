import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heartsnap_monorepo/start/start.dart';

void main() async {
  runApp(
    const MaterialApp(
        home: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(152, 206, 111, 1),
      ),
      child: StartScreen(),
    )),
  );
}
