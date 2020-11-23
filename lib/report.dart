import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

@JsonSerializable()
class Report {
  Report({this.id, this.title, this.body, this.type});

  final int id;
  final String title;
  final String body;
  final String type;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type,
    };
  }

  Future<List<Report>> fetchReports() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'report.db'),
      version: 1,
    );

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reports');
    return List.generate(maps.length, (i) {
      return Report(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
        type: maps[i]['type'],
      );
    });
  }

  Future<int> getIndex() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'report.db'),
      version: 1,
    );
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reports');
    return maps.length;
  }

  Future<void> deleteReport(int id) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'report.db'),
      version: 1,
    );
    final db = await database;
    await db.delete(
      'reports',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> resetDb() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'report.db'),
      version: 1,
    );
    final db = await database;
    await db.delete(
      'reports',
    );
  }

  Future<void> addReport(Report report) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'report.db'),
      version: 1,
    );
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'reports',
      report.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  String toString() {
    return 'Report{title: $title, body: $body, type: $type}';
  }
}
