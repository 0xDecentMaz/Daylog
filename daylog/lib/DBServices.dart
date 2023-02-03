import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBServices {
  late Future<Database> database;

  Future<void> initDB() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'daylog.db'),
      onCreate: (db, version) {
        return db
            .execute(
              'CREATE TABLE activities(id INTEGER PRIMARY KEY, activity TEXT)',
            )
            .then((_) => db.execute(
                  'CREATE TABLE log(id INTEGER PRIMARY KEY, activity TEXT, datetime TEXT)',
                ));
      },
      version: 1,
    );
  }

  Future<void> insertActivity(String activity) async {
    final db = await database;

    await db
        .rawInsert('INSERT INTO activities(activity) VALUES(?)', [activity]);
  }

  Future<void> deleteActivity(int id) async {
    final db = await database;

    await db.rawInsert('DELETE FROM activities WHERE id = ?', [id]);
  }

  /*Future<void> oldInsertActivity(Activities activities) async {
    final db = await database;

    await db.insert(
      'activities',
      activities.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }*/

  Future<List> getActivityList() async {
    // Get a reference to the database.
    final db = await database;

    var result = await db.rawQuery('SELECT activity FROM activities');

    // return a list of results without column name
    return result.map((i) => i["activity"]).toList();
  }

  /*Future<List<Activities>> activities() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The activities.
    final List<Map<String, dynamic>> maps = await db.query('activities');

    // Convert the List<Map<String, dynamic> into a List<Activities>.
    return List.generate(maps.length, (i) {
      return Activities(
        id: maps[i]['id'],
        activity: maps[i]['activity'],
      );
    });
  }*/
}

class Activities {
  final int id;
  final String activity;

  const Activities({
    required this.id,
    required this.activity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'activity': activity,
    };
  }

  @override
  String toString() {
    return 'Activities{id: $id, activity: $activity}';
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
