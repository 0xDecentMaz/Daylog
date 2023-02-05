import 'package:flutter/material.dart';
import 'package:daylog/history_page.dart';
import 'package:daylog/settings_page.dart';
import 'package:daylog/home_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> pages = const [HomePage(), HistoryPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      //backgroundColor: Colors.lightBlue,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.list), label: 'History'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
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
    );
  }
}
