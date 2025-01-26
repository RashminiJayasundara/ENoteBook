import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'e_notebook_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT,
        createdDate DATE,
        lastModifiedDate DATE
      )
    ''');
    await db.execute('''
      CREATE TABLE folders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        isRoot BOOLEAN,
        parentFolder INTEGER,
        createdDate DATE,
        lastModifiedDate DATE,
        userId INTEGER
      )
    ''');
    await db.execute('''
    CREATE TABLE drawings(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    createdDate DATE
    )
    ''');

    await db.execute('''
    CREATE TABLE drawingPoints (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pointX REAL,
    pointY REAL,
    color INTEGER,
    thickness INTEGER,
    drawingId INTEGER,
    FOREIGN KEY (drawingId) REFERENCES drawings(id)
    )
    ''');
  }

  Future<int> insertDrawings() async {
    final db = await database;
    DateTime now = DateTime.now();
    String currentDateTime =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} "
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

    Map<String, dynamic> record = {
      'name': 'New Note',
      'createdDate': currentDateTime,
    };
    return await db.insert('drawings', record);
  }

  Future<int> insertDrawingPoints(Map<String, dynamic> record) async {
    final db = await database;
    return await db.insert('drawingPoints', record);
  }

  Future<List<Map<String, dynamic>>> getDrawingPointsByDrawingId(
      int drawingId) async {
    final db = await database;
    return await db.query(
      'drawingPoints',
      where: 'drawingId = ?',
      whereArgs: [drawingId],
    );
  }
}
