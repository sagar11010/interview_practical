import 'package:interview_task/core/network/model/random_user_response_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        email TEXT,
        profile TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'user.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // for insert list
  static Future<void> insertItem(List<Result> users) async {
    final db = await SQLHelper.db();
    db.execute('delete from user');

    users.forEach((element) async {
      final data = {
        'username': element.name!.first! + element.name!.last!,
        'email': element.email,
        'profile': element.picture!.thumbnail!
      };
      await db.insert('user', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    });
  }

//for get user list
  static Future<List<Result>> getUsers() async {
    final db = await SQLHelper.db();
    List<Map<String, dynamic>> list = await db.query('user', orderBy: "id");
    print("mydata ${list.length}");
    List<Result> userList = [];
    list.forEach((element) {
      userList.add(Result(
          email: element['email'],
          name: Name(first: element['username'], last: ''),
          picture: Picture(thumbnail: element['profile'])));
    });
    return userList;
  }
}
