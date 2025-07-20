import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/weather_entry.dart';

class WeatherDBHelper {
  static final WeatherDBHelper _instance = WeatherDBHelper._internal();
  factory WeatherDBHelper() => _instance;
  WeatherDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'weather.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE weather (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cityName TEXT,
        temperature REAL,
        condition TEXT,
        humidity INTEGER,
        windSpeed REAL
      )
    ''');
  }

  Future<void> insertWeather(WeatherEntry entry) async {
    final db = await database;
    await db.insert('weather', entry.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<WeatherEntry>> getAllWeather() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('weather');

    return maps.map((map) => WeatherEntry.fromMap(map)).toList();
  }

  Future<void> deleteWeather(String cityName) async {
    final db = await database;
    await db.delete('weather', where: 'cityName = ?', whereArgs: [cityName]);
  }

  Future<void> clearAll() async {
    final db = await database;
    await db.delete('weather');
  }
}
