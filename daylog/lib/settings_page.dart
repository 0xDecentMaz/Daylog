import 'package:flutter/material.dart';
import 'db_helper.dart';

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
  String fileName = "";
  String feedback = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "File Name",
                  suffix: Text('.csv')),
              textAlign: TextAlign.center,
              onChanged: (String value) {
                fileName = value;
              },
            ),
            Text(
              feedback,
              style: const TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
              ),
              onPressed: () {
                exportToCSV();
              },
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text('Export as CSV'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void exportToCSV() async {
    debugPrint(fileName);
    if (fileName.isEmpty) {
      feedback = "Enter a file name";
    } else if (fileName.contains(".")) {
      feedback = "Re-enter file name without extensions";
    } else {
      feedback = "";
      await dbservices.exportToCSV("$fileName.csv");
    }

    setState(() {});
  }
}
