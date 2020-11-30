import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Report {
  Report(
      {this.id,
      this.title,
      this.assignee,
      this.component,
      this.defect,
      this.version,
      this.severity,
      this.hardware,
      this.os,
      this.summary,
      this.reporter,
      this.product});

  final int id;
  final String title;
  final String assignee;
  final String component;
  final String defect;
  final String version;
  final String severity;
  final String hardware;
  final String os;
  final String summary;
  final String reporter;
  final String product;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'assignee': assignee,
      'component': component,
      'defect': defect,
      'version': version,
      'severity': severity,
      'hardware': hardware,
      'os': os,
      'summary': summary,
      'reporter': reporter,
      'product': product,
    };
  }

  Future<List<Report>> fetchReports() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );

    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reports');
    return List.generate(maps.length, (i) {
      return Report(
          id: maps[i]['id'],
          title: maps[i]['title'],
          assignee: maps[i]['assignee'],
          component: maps[i]['component'],
          defect: maps[i]['defect'],
          version: maps[i]['version'],
          severity: maps[i]['severity'],
          hardware: maps[i]['hardware'],
          os: maps[i]['os'],
          summary: maps[i]['summary'],
          reporter: maps[i]['reporter'],
          product: maps[i]['product']);
    });
  }

  Future<int> getIndex() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reports');
    return maps.length;
  }

  Future<void> deleteReport(int id) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );
    final db = await database;
    await db.delete(
      'reports',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> resetDb() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
    );
    final db = await database;
    await db.delete(
      'reports',
    );
  }

  Future<void> addReport(Report report) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
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
    return 'Report{title: $title, assignee: $assignee, component: $component, defect: $defect, version: $version, severity: $severity, hardware: $hardware, os: $os, summary: $summary, reporter: $reporter, product: $product}';
  }
}
