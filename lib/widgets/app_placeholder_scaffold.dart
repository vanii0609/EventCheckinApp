import 'package:flutter/material.dart';

import 'responsive_center.dart';

class AppPlaceholderScaffold extends StatelessWidget {
  const AppPlaceholderScaffold({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ResponsiveCenter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}