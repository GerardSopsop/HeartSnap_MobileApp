import 'package:flutter/material.dart';
import 'package:heartsnap_monorepo/diary/foodlistitem.dart';
import 'package:heartsnap_monorepo/util/progress.dart';

import '../database/deletefood.dart';
import '../util/foodname.dart';
import '../util/logo.dart';

class FoodList extends StatefulWidget {
  const FoodList(
      {Key? key,
      required this.user,
      required this.limit,
      required this.img,
      required this.index,
      required this.infos,
      required this.date})
      : super(key: key);
  final String user, date;
  final Map<String, double> limit;
  final Map<String, dynamic> img;
  final List<Map<String, dynamic>> infos;
  final int index;
  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  late ValueNotifier<List<Map<String, dynamic>>> foodList;
  bool change = false;

  TextEditingController cal = TextEditingController();
  TextEditingController carbs = TextEditingController();
  TextEditingController fat = TextEditingController();
  TextEditingController prot = TextEditingController();
  TextEditingController ash = TextEditingController();

  @override
  Widget build(BuildContext context) {
    foodList = ValueNotifier(
        [for (final food in List.from(widget.infos)) Map.from(food)]);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, change);
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(children: [
          Positioned(
            bottom: -30,
            right: -50,
            child: widget.img["cambg1"],
          ),
          Positioned(child: widget.img["cambg2"], top: 0, left: -50),
          Column(
            children: [
              Container(
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Logo(img: widget.img)),
              Text(
                widget.date,
                style: const TextStyle(
                    fontFamily: "Lucidity-Condensed",
                    color: Color.fromRGBO(152, 206, 111, 1),
                    fontSize: 40),
              ),
              const Divider(
                thickness: 2,
                color: Color.fromRGBO(152, 206, 111, 1),
              ),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: foodList,
                builder: (BuildContext context, List<Map<String, dynamic>> val,
                    Widget? child) {
                  if (val.isEmpty) {
                    return Container();
                  }
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      addAutomaticKeepAlives: true,
                      itemCount: val.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: index == 0
                              ? [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: FoodName(
                                      controller: TextEditingController()
                                        ..text = "Total nutriment intakes",
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 10)),
                                  Container(
                                      child: Column(
                                        children: [
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10)),
                                          ProgressBar(
                                              total: widget.limit["kcal"]!,
                                              current: val[0]["kcal"],
                                              text: "Energy calculated (kcal)"),
                                          ProgressBar(
                                              total: widget.limit["saturated"]!,
                                              current: val[0]["saturated"],
                                              text: "Saturated Fat (g)"),
                                          ProgressBar(
                                              total: widget.limit["omega"]!,
                                              current: val[0]["omega"],
                                              text: "Healthy Fat (g)"),
                                          ProgressBar(
                                              total: widget.limit["cholesterol"]!,
                                              current: val[0]["cholesterol"],
                                              text: "Cholesterol (mg)"),
                                          ProgressBar(
                                              total: widget.limit["sodium"]!,
                                              current: val[0]["sodium"],
                                              text: "Sodium (mg)"),
                                          ProgressBar(
                                              total: widget.limit["fiber"]!,
                                              current: val[0]["fiber"],
                                              text: "Dietary Fiber (g)"),
                                          ProgressBar(
                                              total: widget.limit["alcohol"]!,
                                              current: val[0]["alcohol"],
                                              text: "Alcohol (g)"),
                                          ProgressBar(
                                              total: 1,
                                              current: val[0]["trans"],
                                              text: "Trans Fat (g)"),
                                        ],
                                      ),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Color.fromRGBO(
                                              242, 193, 113, 1))),
                                  const Divider(
                                    color: Colors.green,
                                    thickness: 2,
                                  )
                                ]
                              : [
                                  FloatingActionButton(
                                    heroTag: index,
                                    onPressed: () async {
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              popUp(context,
                                                  val[index])).then((value) => {
                                            if (value == "done")
                                              {
                                                foodList.value[0]["kcal"] =
                                                    num.parse((foodList.value[0]
                                                                ["kcal"] -
                                                            foodList.value[
                                                                index]["kcal"])
                                                        .toStringAsFixed(2)).abs(),
                                                        foodList.value[0]["trans"] =
                                                    num.parse((foodList.value[0]
                                                                ["trans"] -
                                                            foodList.value[
                                                                index]["trans"])
                                                        .toStringAsFixed(2)).abs(),foodList.value[0]["saturated"] =
                                                    num.parse((foodList.value[0]
                                                                ["saturated"] -
                                                            foodList.value[
                                                                index]["saturated"])
                                                        .toStringAsFixed(2)).abs(),foodList.value[0]["omega"] =
                                                    num.parse((foodList.value[0]
                                                                ["omega"] -
                                                            foodList.value[
                                                                index]["omega"])
                                                        .toStringAsFixed(2)).abs(),foodList.value[0]["sodium"] =
                                                    num.parse((foodList.value[0]
                                                                ["sodium"] -
                                                            foodList.value[
                                                                index]["sodium"])
                                                        .toStringAsFixed(2)).abs(),foodList.value[0]["fiber"] =
                                                    num.parse((foodList.value[0]
                                                                ["fiber"] -
                                                            foodList.value[
                                                                index]["fiber"])
                                                        .toStringAsFixed(2)).abs(),foodList.value[0]["cholesterol"] =
                                                    num.parse((foodList.value[0]
                                                                ["cholesterol"] -
                                                            foodList.value[
                                                                index]["cholesterol"])
                                                        .toStringAsFixed(2)).abs(),foodList.value[0]["alcohol"] =
                                                    num.parse((foodList.value[0]
                                                                ["alcohol"] -
                                                            foodList.value[
                                                                index]["alcohol"])
                                                        .toStringAsFixed(2)).abs(),
                                                foodList.value.removeAt(index),
                                                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                                foodList.notifyListeners(),
                                                change = true,
                                              }
                                          });
                                    },
                                    elevation: 0,
                                    backgroundColor:
                                        const Color.fromRGBO(240, 136, 151, 1),
                                    child: const Icon(Icons.close),
                                  ),
                                  FoodListItem(
                                    infos: val,
                                    index: index,
                                  ),
                                ],
                        );
                      });
                },
              )),
            ],
          ),
        ]),
      ),
    );
  }

  Widget popUp(BuildContext context, Map<String, dynamic> infos) {
    final double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: Colors.pink[200],
      actionsAlignment: MainAxisAlignment.center,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: const Text(
        "Remove from diary?",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Column(
          children: [
            SizedBox(
              width: width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    splashFactory: NoSplash.splashFactory,
                    primary: const Color.fromRGBO(152, 206, 111, 1),
                    shadowColor: Colors.transparent),
                child: const Text(
                  "YES",
                  style: TextStyle(fontFamily: "DMSans"),
                ),
                onPressed: () async {
                  await deleteFood(infos, widget.user);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(milliseconds: 500),
                    content: Text("'${infos["name"]}' was deleted from diary"),
                  ));
                  Navigator.pop(context, "done");
                },
              ),
            ),
            SizedBox(
              width: width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    splashFactory: NoSplash.splashFactory,
                    primary: Colors.pink[500],
                    shadowColor: Colors.transparent),
                child: const Text(
                  "NO",
                  style: TextStyle(fontFamily: "DMSans"),
                ),
                onPressed: () {
                  Navigator.pop(context, "cancel");
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
