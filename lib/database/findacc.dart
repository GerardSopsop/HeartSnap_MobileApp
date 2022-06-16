import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Map<String, dynamic>> findAccount(String name) async {
  try {
    final database = openDatabase(
      join(await getDatabasesPath(), 'heartsnapDB.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(name TEXT, sex TEXT, height INTEGER, weight INTEGER, disease TEXT, calorie INTEGER)',
        );
      },
      version: 1,
    );

    final db = await database;
    final List<Map<String, dynamic>> user =
        await db.query('users', where: 'name = ?', whereArgs: [name]);
    if (user.isNotEmpty) {
      return user[0];
    }
  } catch (e) {
    null;
  }
  return {"name": ""};
}
