import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FilioDatabase {
  static final FilioDatabase _instance = FilioDatabase._internal();
  factory FilioDatabase() => _instance;

  static Database? _database;

  FilioDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'filio.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE filio_table (id INTEGER PRIMARY KEY, counter INTEGER)",
        );
      },
    );
  }

  Future<void> incrementCounter() async {
    final db = await database;
    await db.rawInsert("INSERT INTO filio_table (counter) VALUES (0)");
    await db.rawUpdate("UPDATE filio_table SET counter = counter + 1 WHERE id = 1");
  }
}
