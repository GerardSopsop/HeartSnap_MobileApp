import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Map<String, double>> getLimit(String user) async {
  try {
    final database = openDatabase(
      join(await getDatabasesPath(), 'heartsnapDB.db'),
    );

    final db = await database;
    List<Map<String, dynamic>> infos = await db.query('users',
        columns: ["sex", "weight", "height", "calorie", "disease"],
        where: "name=?",
        whereArgs: [user]);
    return {
      "kcal": infos[0]["calorie"] * 1.0,
      "saturated": infos[0]["calorie"] * 0.06 * 0.13,
      "omega": infos[0]["calorie"] * 0.35 * 0.13,
      "cholesterol": infos[0]["disease"] == "YES" ? 200.0 : 300.0,
      "sodium": infos[0]["disease"] == "YES" ? 1500.0 : 2300.0,
      "fiber": 30.0,
      "alcohol": infos[0]["sex"] == "male" ? 20.0 : 10.0,
      "trans": 1.0
    };
  } catch (e) {
    null;
  }
  return {};
}
