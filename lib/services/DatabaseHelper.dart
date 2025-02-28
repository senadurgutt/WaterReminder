import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService _instance = DatabaseService.constructor();
  factory DatabaseService() => _instance; // burası fazla olabilir

  final String tableName = 'water_reminder';
  final String id = 'id';
  final String date = 'date';
  final String amount = 'amount';
  final String isCompleted = 'is_completed';

  DatabaseService.constructor();
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'water_reminder_db.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE water_reminder('
          'id INTEGER PRIMARY KEY AUTOINCREMENT'
          'date TEXT, NOT NULL'
          'amount INTEGER, NOT NULL'
          'isCompleted INTEGER'
          ')',
        );
      },
    );
    return database;
  }

  Future<int> addRecord(
    String recordDate,
    int recordAmount,
    bool completed,
  ) async {
    final db = await database;
    return await db.insert(tableName, {
      date: recordDate,
      amount: recordAmount,
      isCompleted: completed ? 1 : 0,
    });
  }

  Future<int> updateRecord(
    int recordId,
    String newDate,
    int newAmount,
    bool completed,
  ) async {
    final db = await database;
    return await db.update(
      tableName,
      {date: newDate, amount: newAmount, isCompleted: completed ? 1 : 0},
      where: '$id = ?',
      whereArgs: [recordId],
    );
  }

  Future<int> removeRecord(int recordId) async {
    final db = await database;
    return await db.delete(tableName, where: '$id = ?', whereArgs: [recordId]);
  }
}
