import 'package:sqflite/sqflite.dart';

import '../data/database_provider.dart';
import '../models/user_model.dart';

class UserRepository {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<List<User>> getUsers() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    });
  }

  Future<void> addUser(User user) async {
    final db = await dbProvider.database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(User user) async {
    final db = await dbProvider.database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await dbProvider.database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
