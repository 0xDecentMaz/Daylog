import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
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

  Future<void> insertActivity(Activities activities) async {
    final db = await database;

    await db.insert(
      'activities',
      activities.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Activities>> activities() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('activities');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Activities(
        id: maps[i]['id'],
        activity: maps[i]['activity'],
      );
    });
  }

  // test an insert
  var testActivity = const Activities(id: 0, activity: 'firstTest');
  await insertActivity(testActivity);

  // test a print
  print(await activities());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Log Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Counter:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
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
