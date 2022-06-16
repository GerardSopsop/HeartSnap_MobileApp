import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info(
      {Key? key, required this.image, required this.text, required this.info})
      : super(key: key);
  final AssetImage image;
  final String text, info;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 200,
            backgroundImage: image,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          SizedBox(
            height: 150,
            child: Column(children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Lucidity-Expand",
                    fontSize: 20,
                    color: Color.fromRGBO(152, 206, 111, 1)),
              ),
              Text(
                info,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "DMSans",
                    color: Color.fromRGBO(152, 206, 111, 1)),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
