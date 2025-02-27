import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService {
  static final DataBaseService _instance = DataBaseService.constructor();

  DataBaseService.constructor();

  Future<Database> getDataBase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'water_reminder_db.db');
  }
}
