/* Packages */
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> initDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'travelapp.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE user_destinations(id TEXT PRIMARY KEY, title TEXT, description TEXT, image TEXT)');
      },
    );
  }

  static Future<void> post(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.initDatabase();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> get(String table) async {
    final db = await DBHelper.initDatabase();
    return db.query(
      table
    );
  }
}
