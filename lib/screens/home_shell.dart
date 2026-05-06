import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'event_setup_screen.dart';
import 'check_in_screen.dart';
import 'logs_search_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 1; // default to Dashboard

  static const List<Widget> _pages = <Widget>[
    EventSetupScreen(),
    DashboardScreen(),
    CheckInScreen(),
    LogsSearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Setup'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Check-in'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Logs'),
        ],
      ),
    );
  }
}