import 'package:getx_database/Model/User.dart';
import 'package:sqflite/sqflite.dart';

import 'DatabaseHelper.dart';

class UserDAO extends DatabaseHelper {
  static const _TABLE_NAME = "user";
  static const ID = "id";
  static const NAME = "name";
  static const CONTACT = "contact";

  static getCreateUserTableQuery() {
    return """
      CREATE TABLE $_TABLE_NAME
      (
        $ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $CONTACT TEXT UNIQUE,
        $NAME TEXT
       
      )
    """;
  }

  //User- insert
  Future<int> insertUser(User user) async {
    Database? db = await getDatabase();
    return await db.insert(_TABLE_NAME, user.toMap());
  }

  // User- Display
  Future<List<User>> fetchContacts() async {
    Database? db = await getDatabase();
    List<Map<String, dynamic>> user = await db.query(_TABLE_NAME);
    print("User length :${user.length}");
    return user.length == 0 ? [] : user.map((x) => User.fromMap(x)).toList();
  }

  Future<int> deleteTask(int id) async {
    Database? db = await getDatabase();
    return await db.delete(_TABLE_NAME, where: ' $ID = ?', whereArgs: [id]);
  }

  Future<int> updateTask(User user) async {
    Database? db = await getDatabase();
    return await db.update(_TABLE_NAME, user.toMap(),
        where: ' $ID = ?', whereArgs: [user.id]);
  }
}
