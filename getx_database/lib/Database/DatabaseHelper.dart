import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'UserDAO.dart';

abstract class DatabaseHelper {
  final int dbVersion = 1;
  final String dbName = "getx.db";
  late String path;

  Future<Database> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, dbName);
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        db.execute(UserDAO.getCreateUserTableQuery());
      },
    );

    return database;
  }
}
