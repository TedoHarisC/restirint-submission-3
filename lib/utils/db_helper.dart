import 'package:restirint/model/local_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  DbHelper._createObject();
  static late Database _db;
  static const String _tableFavoriteRestaurant = 'favorite_restaurant';

  factory DbHelper() => _dbHelper ?? DbHelper._createObject();

  Future<Database> get database async {
    _db = await _initializeDb();

    return _db;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant_db.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableFavoriteRestaurant (
               id TEXT PRIMARY KEY,
               name TEXT, 
               city TEXT,
               pictureId TEXT,
               rating REAL
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertFavoriteRestaurant(LocalRestaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableFavoriteRestaurant, restaurant.toJsonForSql());
  }

  Future<void> deleteFavoriteRestaurant(LocalRestaurant restaurant) async {
    final db = await database;

    await db.delete(
      _tableFavoriteRestaurant,
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<List<LocalRestaurant>> getFavoriteRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableFavoriteRestaurant);

    List<LocalRestaurant> listData = results.isNotEmpty
        ? results.map((item) => LocalRestaurant.fromJson(item)).toList()
        : [];

    return listData;
  }

  Future<bool> checkFavoriteStatus(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableFavoriteRestaurant);

    List<LocalRestaurant> list =
        results.map((item) => LocalRestaurant.fromJson(item)).toList();
    bool status = false;
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        return true;
      } else {
        status = false;
      }
    }
    return status;
  }
}
