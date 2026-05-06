import 'package:flutter/material.dart';

import 'screens/check_in_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/event_setup_screen.dart';
import 'screens/logs_search_screen.dart';
import 'screens/home_shell.dart';

class SmartEventCheckInApp extends StatelessWidget {
  const SmartEventCheckInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Event Check-in & Crowd Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeShell(),
        '/setup': (_) => const EventSetupScreen(),
        '/checkin': (_) => const CheckInScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/logs': (_) => const LogsSearchScreen(),
      },
    );
  }
}