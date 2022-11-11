import 'dart:async';

import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/database_repository.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class SqlDatabase implements DatabaseRepository {
  SqlDatabase._();
  static final SqlDatabase db = SqlDatabase._();

  Database? _database;
  static UserModel? user;

  Future<Database> get database async {
    if (_database != null) return _database!;

    await init();
    return _database!;
  }

  @override
  Future<void> init() async {
    _database = await initDB();
  }

  Future<Database> initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'ottaa_database.db'),
      version: 2,
      onConfigure: _onConfigure,
      onUpgrade: _onUpgrade,
      onDowngrade: _onUpgrade,
      onCreate: _onCreate,
      onOpen: (db) async {
        _database = db;
        user = await getUser();
      },
    );
  }

  Future<void> _onConfigure(db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user (
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT,
        photoUrl TEXT,
        birthdate INTEGER,
        gender TEXT,
        language TEXT,
        isFirstTime INTEGER,
        avatar TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.transaction((txn) {
      return _drop(txn, deleteUser: newVersion % 2 == 0);
    });

    await _onCreate(db, newVersion);
  }

  Future<void> _drop(Transaction db, {bool deleteUser = false}) async {
    if (deleteUser) db.execute('''DROP TABLE IF EXISTS user''');
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.transaction((txn) => _drop(txn, deleteUser: true));
  }

  @override
  Future<void> setUser(UserModel user) async {
    final db = await database;
    await db.delete('user');
    await db.insert('user', user.toMap());

    SqlDatabase.user = user;
  }

  @override
  Future<UserModel?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');

    if (maps.isEmpty) return null;

    return UserModel.fromJson(maps.first);
  }

  @override
  Future<void> deleteUser() async {
    final db = await database;
    await db.delete('user');

    SqlDatabase.user = null;
  }
}
