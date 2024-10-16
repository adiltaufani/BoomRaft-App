import 'package:flutter_project/zzunused/wishlist/model/wishlist_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WishlistDatabaseHelper {
  static Database? _database;
  static const String _tableName = 'wishlist';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'wishlist.db');
    return openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_penginapan TEXT,
        harga TEXT,
        hotel_id TEXT,
        address TEXT,
        uid TEXT,
        url_foto TEXT
      )
    ''');
  }

  static Future<void> insertWishlist(WishlistModel notification) async {
    final db = await database;
    await db.insert(_tableName, notification.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<WishlistModel>> getWishlist(String currentUserUid) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'uid = ?',
      whereArgs: [currentUserUid],
    );
    return List.generate(maps.length, (i) {
      return WishlistModel.fromMap(maps[i]);
    });
  }

  static Future<void> deleteWishlist(int id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
