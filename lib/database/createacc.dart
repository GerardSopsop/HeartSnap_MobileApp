import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> createAccount(Map<String, dynamic> infos) async {
  try {
    final database = openDatabase(
      join(await getDatabasesPath(), 'heartsnapDB.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users(name TEXT, sex TEXT, disease TEXT, height INTEGER, weight INTEGER, calorie INTEGER)',
        );
      },
      version: 1,
    );

    final db = await database;
    await db.insert('users', infos);
    await db.execute(
        'CREATE TABLE ${infos["name"]} (name TEXT, kcal REAL, saturated REAL, trans REAL, omega REAL, cholesterol REAL, sodium REAL, fiber REAL, alcohol REAL, path TEXT, date TEXT, time TEXT)');
  } catch (e) {
    null;
  }
}
