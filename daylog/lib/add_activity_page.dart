import 'package:flutter/material.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Activity'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}
