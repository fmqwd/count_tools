import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute("""
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        user_key TEXT NOT NULL,
        ext TEXT
      )
    """);
    await db.execute("""
      CREATE TABLE project_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        subTitle TEXT,
        count TEXT,
        ext TEXT
      )
    """);
    await db.execute("""
      CREATE TABLE sub_project_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        count TEXT NOT NULL,
        countPre TEXT NOT NULL,
        color TEXT NOT NULL,
        textColor TEXT NOT NULL,
        parentId TEXT NOT NULL,
        ext TEXT
      )
    """);
    await db.execute("""
      CREATE TABLE item_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        price TEXT,
        eventName TEXT,
        type TEXT,
        date TEXT NOT NULL,
        itemName TEXT NOT NULL,
        parentId TEXT NOT NULL,
        projectId TEXT NOT NULL,
        ext TEXT
      )
    """);
    await db.execute("""
      CREATE TABLE activity_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        desc TEXT,
        date TEXT NOT NULL,
        time ,
        address TEXT,
        price TEXT,
        chikaNum TEXT,
        peopleNum TEXT,
        ext TEXT
      )
    """);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
