import 'package:flutter/material.dart';
import 'DBServices.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity History'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const ActivityLogTable(),
    );
  }
}

class ActivityLogTable extends StatefulWidget {
  const ActivityLogTable({super.key});

  @override
  State<ActivityLogTable> createState() => _ActivityLogTableState();
}

class _ActivityLogTableState extends State<ActivityLogTable> {
  final DBServices dbServices = DBServices();
  List<dynamic> activityLog = [];

  @override
  void initState() {
    _fetchLog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'ID',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'DATETIME',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'ACTIVITY',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('0')),
            DataCell(Text('2023-02-02')),
            DataCell(Text('Pet Cat')),
          ],
        ),
      ],
    );
  }

  void _fetchLog() async {
    final list = await dbServices.getActivityList();
    activityLog = list;
    setState(() {});
  }
}
