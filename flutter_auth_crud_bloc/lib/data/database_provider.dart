import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';

class DatabaseProvider {
  static const String _databaseName = "myDatabase.db";
  static const int _databaseVersion = 1;

  static final DatabaseProvider dbProvider = DatabaseProvider._();

  Database? _database;

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

    return await openDatabase(path, version: _databaseVersion,
        onCreate: (Database database, int version) async {
      await database.execute(
        "CREATE TABLE users ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "email TEXT,"
        "password TEXT"
        ")",
      );
    });
  }
}
