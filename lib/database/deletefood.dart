import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> deleteFood(Map<String, dynamic> infos, String user) async {
  try {
    final database = openDatabase(
      join(await getDatabasesPath(), 'heartsnapDB.db'),
    );

    final db = await database;
    await db.delete(user, where: "path = ?", whereArgs: [infos["path"]]);
    List<Map<String, dynamic>> getTotal = List.from(await db
        .query(user, where: "date = ?", whereArgs: ["${infos["date"]}"]));
    if (getTotal.length == 1) {
      await db.delete(user,
          where: "date = ? and name = ?",
          whereArgs: [infos["date"], "Total Nutritional Facts"]);
      return;
    }
    Map<String, dynamic> current = Map.from(getTotal[0]);
    await db.update(
        user,
        {
          "kcal":
              num.parse((current["kcal"] - infos["kcal"]).toStringAsFixed(3)),
          "saturated": num.parse(
              (current["saturated"] - infos["saturated"]).toStringAsFixed(3)),
          "trans":
              num.parse((current["trans"] - infos["trans"]).toStringAsFixed(3)),
          "omega":
              num.parse((current["omega"] - infos["omega"]).toStringAsFixed(3)),
          "sodium": num.parse(
              (current["sodium"] - infos["sodium"]).toStringAsFixed(3)),
          "alcohol": num.parse(
              (current["alcohol"] - infos["alcohol"]).toStringAsFixed(3)),
          "fiber":
              num.parse((current["fiber"] - infos["fiber"]).toStringAsFixed(3)),
          "cholesterol": num.parse(
              (current["cholesterol"] - infos["cholesterol"])
                  .toStringAsFixed(3)),
        },
        where: "name = ? and date = ?",
        whereArgs: ["Total Nutritional Facts", "${infos["date"]}"]);
  } catch (e) {
    null;
  }
}
