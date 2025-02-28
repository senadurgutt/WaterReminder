import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseService {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
      CREATE TABLE records(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        amount INTEGER NOT NULL,
        note TEXT
      )
    ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "water_reminder.db",
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await createTables(db);
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final database = await db();
    return database.query("records");
  }

  static Future<int> createData(String date, int amount, String note) async {
    final database = await db();
    return database.insert("records", {
      "date": date,
      "amount": amount,
      "note": note,
    });
  }

  static Future<List<Map<String, dynamic>>> readData() async {
    final database = await db();
    return database.query("records");
  }

  static Future<int> updateData(
    int id,
    String date,
    int amount,
    String note,
  ) async {
    final database = await db();
    try {
      return await database.update(
        "records",
        {"date": date, "amount": amount, "note": note},
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      print("Güncelleme hatası: $e");
      return 0;
    }
  }

  static Future<int> deleteData(int id) async {
    final database = await db();
    return database.delete("records", where: "id = ?", whereArgs: [id]);
  }

  static Future<int> deleteAllData() async {
    final database = await db();
    return database.rawDelete("DELETE FROM records");
  }

  static Future<void> close() async {
    final database = await db();
    return database.close();
  }

  static Future<void> init() async {
    await db();
  }
}
