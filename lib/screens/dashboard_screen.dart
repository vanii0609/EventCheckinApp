import 'package:flutter/material.dart';

import '../widgets/app_placeholder_scaffold.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPlaceholderScaffold(
      title: 'Dashboard',
      message: 'Phase 1 placeholder for summary cards and crowd status.',
    );
  }
}