import 'package:daylog/history_page.dart';
import 'package:daylog/settings_page.dart';
import 'package:daylog/main.dart';
import 'package:flutter/material.dart';
import 'DBServices.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DBServices dbServices = DBServices();
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
          title: const Text('Log Test Home'),
        ),
        body: ListView.builder(
          itemCount: activityList.length,
          itemBuilder: (_, index) {
            var activity = activityList[index];
            return Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      debugPrint(activity);
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
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.list), label: 'History'),
            NavigationDestination(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onDestinationSelected: (int index) {
            if (index != 0) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return pages[index];
                  },
                ),
              );
            } else {
              //do nothing since already on homepage
            }
          },
        ),
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
/*
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const AddActivityPage();
              },
            ),
          );
        },
        child: const Text('Add New Activity'),
      ),
    );
  }
}
*/
