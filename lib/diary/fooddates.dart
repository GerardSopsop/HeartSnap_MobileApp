import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/diary/fooddateitem.dart';

import '../database/getlimit.dart';
import '../database/getlist.dart';
import 'foodlist.dart';

class FoodDate extends StatefulWidget {
  const FoodDate({Key? key, required this.user, required this.img})
      : super(key: key);
  final String user;
  final Map<String, dynamic> img;
  @override
  State<FoodDate> createState() => _FoodDateState();
}

class _FoodDateState extends State<FoodDate> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width - 60;
    return Expanded(
      child: FutureBuilder<List<List<Map<String, dynamic>>>>(
          future: getFood(widget.user, "date"),
          builder: (BuildContext context,
              AsyncSnapshot<List<List<Map<String, dynamic>>>> snapshot) {
            if (snapshot.hasData) {
              final int len = (snapshot.data!.length / 2).ceil();
              return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: len,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width / 2 - 2.5,
                            child: GestureDetector(
                              onTap: () async {
                                Map<String, double> limits =
                                    await getLimit(widget.user);
                                final pageNext = await Future.microtask(() {
                                  return FoodList(
                                      limit: limits,
                                      user: widget.user,
                                      img: widget.img,
                                      date: snapshot.data![2 * index][0]
                                          ["date"]!,
                                      index: index,
                                      infos: snapshot.data![2 * index]);
                                });
                                final route =
                                    MaterialPageRoute(builder: (_) => pageNext);
                                Navigator.push(context, route).then((value) => {
                                      if (value) {setState(() {})}
                                    });
                              },
                              child: FoodDateItem(
                                infos: snapshot.data![2 * index],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                          ),
                          SizedBox(
                            width: width / 2 - 2.5,
                            child: (2 * index) + 2 <= snapshot.data!.length
                                ? GestureDetector(
                                    onTap: () async {
                                      Map<String, double> limits =
                                          await getLimit(widget.user);
                                      final pageNext =
                                          await Future.microtask(() {
                                        return FoodList(
                                            user: widget.user,
                                            limit: limits,
                                            img: widget.img,
                                            date:
                                                snapshot.data![(2 * index) + 1]
                                                    [0]["date"]!,
                                            index: index,
                                            infos: snapshot
                                                .data![(2 * index) + 1]);
                                      });
                                      final route = MaterialPageRoute(
                                          builder: (_) => pageNext);
                                      Navigator.push(context, route)
                                          .then((value) => {
                                                if (value) {setState(() {})}
                                              });
                                    },
                                    child: FoodDateItem(
                                      infos: snapshot.data![(2 * index) + 1],
                                    ),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return Container();
          }),
    );
  }
}
