import 'package:daylog/history_page.dart';
import 'package:daylog/settings_page.dart';
import 'package:daylog/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbservices = DatabaseHelper.instance;

  List activityList = [];
  String valueText = '';
  List<Widget> pages = const [HomePage(), HistoryPage(), SettingsPage()];

  @override
  void initState() {
    _fetchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Logitall'),
        ),
        body: ListView.builder(
          itemCount: activityList.length,
          itemBuilder: (_, index) {
            var activity = activityList[index];
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      _logActivity(activity);
                    },
                    onLongPress: () {
                      _deleteActivityDialog(activity);
                    },
                    child: Text(activity))
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _newActivityDialog();
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }

  void _fetchList() async {
    final list = await dbservices.getActivityList();
    activityList = list;
    setState(() {});
  }

  void _addToList() async {
    debugPrint('Creating Activity $valueText');
    await dbservices.insertActivity(valueText);
    _fetchList();
  }

  void _logActivity(String activity) async {
    DateTime now = DateTime.now();
    String datetime =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    debugPrint('Log: $activity - $datetime');
    await dbservices.insertActivityLog(activity, datetime);
  }

  void _deleteFromList(String activity) async {
    debugPrint('Deleteing Activity: $activity');
    await dbservices.deleteActivity(activity);
    _fetchList();
  }

  Future<void> _newActivityDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create a new activity'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(onChanged: (value) {
                  setState(() {
                    valueText = value;
                  });
                }),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('Create'),
              onPressed: () {
                Navigator.of(context).pop();
                _addToList();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteActivityDialog(String activity) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Activity'),
          content: SingleChildScrollView(
            child: Text('Do you want to delete $activity ?'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteFromList(activity);
              },
            ),
          ],
        );
      },
    );
  }
}
