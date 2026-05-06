import 'package:flutter/material.dart';

import 'screens/check_in_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/event_setup_screen.dart';
import 'screens/logs_search_screen.dart';

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
      initialRoute: '/dashboard',
      routes: {
        '/': (_) => const EventSetupScreen(),
        '/setup': (_) => const EventSetupScreen(),
        '/checkin': (_) => const CheckInScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/logs': (_) => const LogsSearchScreen(),
      },
    );
  }
}