import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> addFood(Map<String, dynamic> infos, String user) async {
  try {
    final database = openDatabase(
      join(await getDatabasesPath(), 'heartsnapDB.db'),
    );

    final db = await database;
    List<Map<String, dynamic>> getTotal = List.from(await db.query(user,
        where: "name = ? and date = ?",
        whereArgs: ["Total Nutritional Facts", "${infos["date"]}"]));

    if (getTotal.isEmpty) {
      await db.insert(user, {
        "name": "Total Nutritional Facts",
        "kcal": infos["kcal"],
        "saturated": infos["saturated"],
        "trans": infos["trans"],
        "omega": infos["omega"],
        "sodium": infos["sodium"],
        "alcohol": infos["alcohol"],
        "fiber": infos["fiber"],
        "cholesterol": infos["cholesterol"],
        "path": "",
        "date": "${infos["date"]}",
        "time": ""
      });
    } else {
      Map<String, dynamic> current = Map.from(getTotal[0]);
      await db.update(
          user,
          {
            "kcal":
                num.parse((current["kcal"] + infos["kcal"]).toStringAsFixed(3)),
            "saturated": num.parse(
                (current["saturated"] + infos["saturated"]).toStringAsFixed(3)),
            "trans": num.parse(
                (current["trans"] + infos["trans"]).toStringAsFixed(3)),
            "omega": num.parse(
                (current["omega"] + infos["omega"]).toStringAsFixed(3)),
            "sodium": num.parse(
                (current["sodium"] + infos["sodium"]).toStringAsFixed(3)),
            "alcohol": num.parse(
                (current["alcohol"] + infos["alcohol"]).toStringAsFixed(3)),
            "fiber": num.parse(
                (current["fiber"] + infos["fiber"]).toStringAsFixed(3)),
            "cholesterol": num.parse(
                (current["cholesterol"] + infos["cholesterol"])
                    .toStringAsFixed(3)),
          },
          where: "name = ? and date = ?",
          whereArgs: ["Total Nutritional Facts", "${infos["date"]}"]);
    }

    await db.insert(user, infos);
  } catch (e) {
    null;
  }
}
