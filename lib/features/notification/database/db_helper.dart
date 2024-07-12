import 'package:flutter_project/features/notification/model/notification_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotificationDatabaseHelper {
  static Database? _database;
  static const String _tableName = 'notifications';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'notifications.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        body TEXT,
        uid TEXT,
        time TEXT
      )
    ''');
  }

  static Future<void> insertNotification(NotifModel notification) async {
    final db = await database;
    await db.insert(_tableName, notification.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<NotifModel>> getNotifications(
      String currentUserUid) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'uid = ?',
      whereArgs: [currentUserUid],
    );
    return List.generate(maps.length, (i) {
      return NotifModel.fromMap(maps[i]);
    });
  }

  static Future<void> deleteNotifications(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> deleteAllNotifications() async {
    final db = await database;
    await db.delete(_tableName);
  }
}
