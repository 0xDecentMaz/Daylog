import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/*
Many thanks to user manishdayma on github, it was of great help to read his implementation of 
database helper: 
https://github.com/manishdayma/flutter_sqflite_crud/blob/main/lib/db_manager.dart
*/

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database?> get database1 async {
    _database ??= await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'daylog.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE activities(id INTEGER PRIMARY KEY, activity TEXT)',
    );
    await db.execute(
      'CREATE TABLE log(id INTEGER PRIMARY KEY, activity TEXT, datetime TEXT)',
    );
  }

  Future<void> insertActivity(String activity) async {
    final db = await database;

    await db
        .rawInsert('INSERT INTO activities(activity) VALUES(?)', [activity]);
  }

  Future<void> insertActivityLog(String activity, String datetime) async {
    final db = await database;

    await db.rawInsert('INSERT INTO log(activity, datetime) VALUES(?,?)',
        [activity, datetime]);
  }

  Future<void> deleteActivity(String activity) async {
    final db = await database;

    await db.rawInsert('DELETE FROM activities WHERE activity = ?', [activity]);
  }

  Future<List> getActivityList() async {
    // Get a reference to the database.
    final db = await database;

    var result = await db.rawQuery('SELECT activity FROM activities');

    // return a list of results without column name
    return result.map((i) => i["activity"]).toList();
  }

  Future<List<Log>> getActivityLog() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The activities.
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM log ORDER BY id DESC');

    // Convert the List<Map<String, dynamic> into a List<Activities>.
    return List.generate(maps.length, (i) {
      return Log(
        id: maps[i]['id'],
        activity: maps[i]['activity'],
        datetime: maps[i]['datetime'],
      );
    });
  }

  Future<String> exportToCSV(String fileName) async {
    List<List<dynamic>> csvList = [];
    List<Log> dbList = await getActivityLog();

    for (int i = 0; i < dbList.length; i++) {
      List<String> list = [];

      list.add(dbList[i].id.toString());
      list.add(dbList[i].activity.toString());
      list.add(dbList[i].datetime.toString());

      csvList.add(list);
    }

    String csv = const ListToCsvConverter().convert(csvList);

    String dir = await getInternalDirectoryPath();
    String fullDir = join(dir, fileName);
    debugPrint(fullDir);
    File csvFile = File(fullDir);
    await csvFile.writeAsString(csv);

    List<XFile> xfiles = [];
    xfiles.add(XFile(fullDir));
    Share.shareXFiles(xfiles);

    return fullDir;
  }

  Future<String> getInternalDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

class Log {
  final int id;
  final String activity;
  final String datetime;

  const Log({
    required this.id,
    required this.activity,
    required this.datetime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'activity': activity,
      'datetime': datetime,
    };
  }

  @override
  String toString() {
    return 'Log{id: $id, activity: $activity, datetime: $datetime}';
  }
}
