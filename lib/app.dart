import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/event_provider.dart';
import 'services/storage_service.dart';
import 'screens/check_in_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/event_setup_screen.dart';
import 'screens/logs_search_screen.dart';
import 'screens/home_shell.dart';

class SmartEventCheckInApp extends StatefulWidget {
  const SmartEventCheckInApp({super.key});

  @override
  State<SmartEventCheckInApp> createState() => _SmartEventCheckInAppState();
}

class _SmartEventCheckInAppState extends State<SmartEventCheckInApp> {
  late final Future<StorageService> _storageFuture = _bootstrapStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StorageService>(
      future: _storageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return ChangeNotifierProvider(
          create: (_) => EventProvider(snapshot.data!),
          child: MaterialApp(
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
          ),
        );
      },
    );
  }

  Future<StorageService> _bootstrapStorage() async {
    final storage = StorageService();
    await storage.init();
    return storage;
  }
}