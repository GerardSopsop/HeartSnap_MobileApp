import "package:flutter/material.dart";
import 'package:url_launcher/url_launcher.dart';

class HeartItem extends StatelessWidget {
  const HeartItem(
      {Key? key,
      required this.label,
      required this.info,
      required this.link,
      required this.img})
      : super(key: key);
  final String label, info, link;
  final Image img;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 100;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60.0),
              ),
              splashFactory: NoSplash.splashFactory,
              primary: const Color.fromRGBO(236, 236, 236, 1),
              shadowColor: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.27,
                      child: img,
                    ),
                    Padding(padding: EdgeInsets.only(right: width * 0.03)),
                    SizedBox(
                      width: width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            label,
                            style: const TextStyle(
                                fontFamily: "Lucidity-Condensed",
                                fontSize: 15,
                                color: Colors.black),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                          ),
                          Text(
                            info,
                            style: const TextStyle(
                                fontFamily: "DMSans",
                                fontSize: 9,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
          onPressed: () async {
            if (!await launchUrl(Uri.parse(link))) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text("Unable to load link"),
              ));
            }
          },
        ),
      ),
    );
  }
}
