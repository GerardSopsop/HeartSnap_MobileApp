import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:heartsnap_monorepo/heart/heartitem.dart';

import '../util/logo.dart';

class Heart extends StatefulWidget {
  const Heart({Key? key, required this.img}) : super(key: key);
  final Map<String, dynamic> img;
  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          bottom: -50,
          right: -30,
          child: widget.img["listbg"],
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, bottom: 5),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Logo(img: widget.img)),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              const Text(
                "Articles about Food and Heart",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Lucidity-Expand",
                    color: Color.fromRGBO(152, 206, 111, 1),
                    fontSize: 20),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Expanded(
                child: FutureBuilder<List<List<dynamic>>>(
                    future: loadAsset(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<List<dynamic>>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return HeartItem(
                                  label: snapshot.data![index][0],
                                  info: snapshot.data![index][1],
                                  link: snapshot.data![index][2],
                                  img: widget.img["logo2"]);
                            });
                      }
                      return Container();
                    }),
              )
            ],
          ),
        )
      ]),
    );
  }

  Future<List<List<dynamic>>> loadAsset() async {
    final myData = await rootBundle.loadString("files/articles.csv");
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(myData);
    for (final item in csvTable) {
      if (item[1].length > 150) {
        item[1] = item[1].substring(0, 150) + "...";
      }
    }
    return csvTable;
  }
}
