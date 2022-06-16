import 'package:flutter/material.dart';

class ChooseItem extends StatelessWidget {
  const ChooseItem({Key? key, required this.type, required this.img})
      : super(key: key);
  final int type;
  final Map<String, dynamic> img;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 20;
    return SizedBox(
      width: width / 2 - 5,
      height: 200,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: type == 1 ? img["item1"] : img["item2"])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == 1
                  ? Icons.camera_alt
                  : type == 2
                      ? Icons.document_scanner
                      : Icons.search_rounded,
              size: 50,
              color: Colors.white,
            ),
            Text(
              type == 1 ? "Upload food picture" : "Scan product barcode",
              style:
                  const TextStyle(color: Colors.white, fontSize: 15, shadows: [
                Shadow(color: Colors.black, blurRadius: 10),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
