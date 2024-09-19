import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_example/note_model.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  final String _tableName = "notes";
  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE IF NOT EXISTS notes(
        noteId INTEGER PRIMARY KEY AUTOINCREMENT,
        priority TEXT NOT NULL,
        heading TEXT NOT NULL,
        description TEXT NOT NULL
        )
      ''');
      },
    );
    return database;
  }

  void addNote(String priorityValue, String headingValue,
      String descriptionValue) async {
    final db = await database;
    await db.insert(_tableName, {
      "priority": priorityValue,
      "heading": headingValue,
      "description": descriptionValue
    });
  }

  Future<List<NoteModel>> getNotes() async {
    final db = await database;
    final data = await db.query(_tableName);
    List<NoteModel> notes = data
        .map((e) => NoteModel(
              prioroty: e["priority"] as String,
              heading: e["heading"] as String,
              description: e["description"] as String,
              id: e["noteId"] as int,
            ))
        .toList();
    return notes;
  }
}
