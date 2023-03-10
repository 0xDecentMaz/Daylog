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
      body: const SingleChildScrollView(
        child: ActivityLogTable(),
      ),
    );
    //),
  }
}

class ActivityLogTable extends StatefulWidget {
  const ActivityLogTable({super.key});

  @override
  State<ActivityLogTable> createState() => _ActivityLogTableState();
}

class _ActivityLogTableState extends State<ActivityLogTable> {
  DatabaseHelper dbservices = DatabaseHelper.instance;
  List<Log> activityLog = [];

  @override
  void initState() {
    _fetchLog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DataTable(
        columns: _getColumns(),
        rows: _getDataRows(),
      ),
    );
  }

  void _fetchLog() async {
    final list = await dbservices.getActivityLog();
    activityLog = list;
    setState(() {});
  }

  List<DataRow> _getDataRows() {
    List<DataRow> rows = [];

    for (int i = 0; i < activityLog.length; i++) {
      rows.add(
        DataRow(
          cells: [
            DataCell(
              Text(activityLog[i].datetime.toString()),
            ),
            DataCell(
              Text(activityLog[i].activity.toString()),
            ),
          ],
        ),
      );
    }

    return rows;
  }

  List<DataColumn> _getColumns() {
    return const [
      DataColumn(label: Text('Datetime')),
      DataColumn(label: Text('Activity'))
    ];
  }
}
