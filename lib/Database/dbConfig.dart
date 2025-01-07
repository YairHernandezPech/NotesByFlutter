import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBConfig {
  static final DBConfig _instance = DBConfig._internal();
  static Database? _database;

  factory DBConfig() {
    return _instance;
  }

  DBConfig._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'mydatabase.db'); // Nombre de la base de datos

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Crear tabla de notas
    await db.execute('''
CREATE TABLE Notes (
    note_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    note TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  )
''');
  }
}
