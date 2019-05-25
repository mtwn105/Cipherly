import 'dart:async';
import 'dart:io';

import 'package:cipherly/model/PasswordModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Passwords ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "app_name TEXT,"
          "icon TEXT,"
          "color TEXT,"
          "password TEXT,"
          "user_name TEXT"
          ")");
    });
  }

  newPassword(Password password) async {
    final db = await database;
    var res = await db.insert("Passwords",password.toJson());
    return res;
  }

  getPassword(int id) async {
    final db = await database;
    var res = await db.query("Passwords", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Password.fromJson(res.first) : Null;
  }

  getAllPasswords() async {
    final db = await database;
    var res = await db.query("Passwords");
    List<Password> list =
        res.isNotEmpty ? res.map((c) => Password.fromJson(c)).toList() : [];
    return list;
  }

  updatePassword(Password newClient) async {
    final db = await database;
    var res = await db.update("Passwords", newClient.toJson(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  deletePassword(int id) async {
    final db = await database;
    db.delete("Passwords", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.delete("Passwords");
  }
}
