import 'package:flutter/material.dart';

import '../widgets/app_placeholder_scaffold.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppPlaceholderScaffold(
      title: 'Check-in',
      message: 'Phase 1 placeholder for manual and QR check-in flow.',
    );
  }
}