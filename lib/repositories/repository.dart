import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/repositories/db_connectikon.dart';

class Repository {
  late DatabaseConnection _connection;

  Repository() {
    _connection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _connection.setDatabase();
    return _database;
  }

  Future<int?> save(String table, Map<String, dynamic> data) async {
    var conn = await database;
    return await conn?.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    var conn = await database;
    return await conn!.query(table);
  }

  Future<List<Map<String, dynamic>>> getById(
      String table, int categoryId) async {
    var conn = await database;
    return await conn!.query(table, where: 'id = ?', whereArgs: [categoryId]);
  }

  Future<int?> update(String table, Map<String, dynamic> data) async {
    var conn = await database;
    return await conn!
        .update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int?> delete(String table, int itemId) async {
    var conn = await database;
    return await conn!.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  getByColumnName(String table, String columnName, String columnvalue) async {
    var conn = await database;
    return await conn
        ?.query(table, where: '$columnName = ? ', whereArgs: [columnvalue]);
  }
}
