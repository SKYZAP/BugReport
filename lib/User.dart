import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.password});

  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
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
        firstName: maps[i]['firstName'],
        lastName: maps[i]['lastName'],
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
        firstName: user[index]['firstName'],
        lastName: user[index]['lastName'],
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
        columns: [
          "id",
          "email",
          "firstName",
          "lastName",
          "password",
          "username"
        ],
        where: 'id = ?',
        whereArgs: [id]);

    var selectedUser;

    List.generate(user.length, (index) {
      return selectedUser = User(
        id: user[index]['id'],
        firstName: user[index]['firstName'],
        lastName: user[index]['lastName'],
        username: user[index]['username'],
        password: user[index]['password'],
        email: user[index]['email'],
      );
    });

    return selectedUser;
  }

  Future<String> getEmail(String username) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );
    final db = await database;
    final List<Map<String, dynamic>> user = await db.query('users',
        columns: [
          "id",
          "email",
          "firstName",
          "lastName",
          "password",
          "username"
        ],
        where: 'username = ?',
        whereArgs: [username]);

    var selectedUser;

    List.generate(user.length, (index) {
      return selectedUser = User(
        id: user[index]['id'],
        firstName: user[index]['firstName'],
        lastName: user[index]['lastName'],
        username: user[index]['username'],
        password: user[index]['password'],
        email: user[index]['email'],
      );
    });

    return selectedUser.email;
  }

  Future<void> createDb() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, username TEXT, email TEXT, password TEXT)",
        );
        db.execute(
          "CREATE TABLE reports(id INTEGER PRIMARY KEY, title TEXT, assignee TEXT, component TEXT, defect TEXT, version TEXT, severity TEXT, hardware TEXT, os TEXT, summary TEXT, reporter TEXT, product TEXT)",
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
          "CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, username TEXT, email TEXT, password TEXT)",
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
    return 'User{firstName, $firstName, lastName: $lastName, username: $username, email: $email, password: $password}';
  }
}
