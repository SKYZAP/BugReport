import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  User({this.id, this.username, this.email, this.password});

  final int id;
  final String username;
  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  Future<List<User>> fetchUsers() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
        email: maps[i]['email'],
      );
    });
  }

  Future<bool> signIn(String username, String password) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );
    final db = await database;
    final List<Map<String, dynamic>> user =
        await db.query('users', where: 'username = ?', whereArgs: [username]);

    var selectedUser;
    List.generate(user.length, (index) {
      return selectedUser = User(
        id: user[index]['id'],
        username: user[index]['username'],
        password: user[index]['password'],
        email: user[index]['email'],
      );
    });

    if (selectedUser.password == password) {
      return true;
    }

    return false;
  }

  Future<User> getUser(int id) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );
    final db = await database;
    final List<Map<String, dynamic>> user = await db.query('users',
        columns: ["id", "email", "password", "username"],
        where: 'id = ?',
        whereArgs: [id]);

    var selectedUser;

    List.generate(user.length, (index) {
      return selectedUser = User(
        id: user[index]['id'],
        username: user[index]['username'],
        password: user[index]['password'],
        email: user[index]['email'],
      );
    });

    return selectedUser;
  }

  Future<void> createDb() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)",
        );
        db.execute(
          "CREATE TABLE reports(id INTEGER PRIMARY KEY, title TEXT, body TEXT, type TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> addUser(User user) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)",
        );
      },
      version: 1,
    );
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getIndex() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return maps.length;
  }

  @override
  String toString() {
    return 'User{username: $username, email: $email, password: $password}';
  }
}
