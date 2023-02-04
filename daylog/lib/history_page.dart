import 'package:flutter/material.dart';
import 'db_helper.dart';

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
  DatabaseHelper dbservices = DatabaseHelper.instance;
  List<dynamic> activityLog = [];

  @override
  void initState() {
    _fetchLog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: _getColumns(),
      rows: _getDataRows(),
    );
  }

  void _fetchLog() async {
    final list = await dbservices.getActivityLog();
    activityLog = list;
    setState(() {});
  }

  List<DataRow> _getDataRows() {
    //List<DataRow>
    List<DataRow> rows = [];

    //generate selected user nested data
    for (var row in activityLog) {
      rows.add(
        DataRow(
          cells: [
            DataCell(
              Text(row['id'].toString()),
            ),
            DataCell(
              Text(row['activity']),
            ),
            DataCell(
              Text(row['datetime'].toString()),
            ),
          ],
        ),
      );
    }
    return rows;
  }

  List<DataColumn> _getColumns() {
    return const [
      DataColumn(label: Text('id')),
      DataColumn(label: Text('activity')),
      DataColumn(label: Text('datetime'))
    ];
  }
}
