import 'package:flutter/material.dart';
//import 'package:request_permission/request_permission.dart';
import 'db_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: ExportWidget(),
      ),
    );
  }
}

class ExportWidget extends StatefulWidget {
  const ExportWidget({super.key});

  @override
  State<ExportWidget> createState() => _ExportWidgetState();
}

class _ExportWidgetState extends State<ExportWidget> {
  DatabaseHelper dbservices = DatabaseHelper.instance;
  String exportResult = "";
  String exportDir = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              exportToCSV();
            },
            child: const Text('Export to CSV'),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: exportResult,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: exportDir,
            ),
          )
        ],
      ),
    );
  }

  void exportToCSV() async {
    // get permission for external storage
    if (await Permission.manageExternalStorage.request().isGranted) {
      exportResult = "Export started";
      setState(() {});
      String dir = await dbservices.exportToCSV();
      exportResult = "Export complete";
      exportDir = dir;
      setState(() {});
    }
  }
}
