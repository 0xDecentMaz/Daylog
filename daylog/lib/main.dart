import 'package:daylog/home_page.dart';
import 'package:flutter/material.dart';

//DBServices dbservices = DBServices();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logitall',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
            primary: Colors.black12,
            secondary: Colors.amber,
            tertiary: Colors.white12),
      ),
      home: const HomePage(),
    );
  }
}
