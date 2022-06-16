import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<List<List<Map<String, dynamic>>>> getFood(
    String user, String filter) async {
  try {
    final database = openDatabase(
      join(await getDatabasesPath(), 'heartsnapDB.db'),
    );

    final db = await database;
    final List<Map<String, dynamic>> getFood = List.from(await db.query(user));
    Map<String, List<Map<String, dynamic>>> foodDiary = {};
    for (final food in getFood) {
      if (foodDiary.containsKey(food["date"])) {
        foodDiary[food["date"]]!.add(food);
      } else {
        foodDiary[food["date"]] = [food];
      }
    }

    List<List<Map<String, dynamic>>> result = [
      for (final String key in foodDiary.keys) foodDiary[key]!
    ];
    return result;
  } catch (e) {
    null;
  }
  return [];
}
