import 'dart:developer';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_eltodo');
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreatingDatabase,
    );
    log('Database path: $path');  // Debug log statement
    return database;
  }

  Future<void> _onCreatingDatabase(Database db, int version) async {
    await db.execute(
      'CREATE TABLE categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
    );
    log('Created categories table');  // Debug log statement
    await db.execute(
      'CREATE TABLE TODO(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, todoDate TEXT, isFinished INTEGER)',
    );
    log('Created TODO table');  // Debug log statement
  }
}
