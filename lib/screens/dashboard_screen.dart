import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../widgets/responsive_center.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();

    final total = eventProvider.totalCapacity;
    final checkedIn = eventProvider.checkedInCount;
    final remaining = total - checkedIn;
    final percent = total == 0 ? 0.0 : (checkedIn / total) * 100;
    final status = eventProvider.crowdStatus;

    return ResponsiveCenter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Dashboard', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('Total', total.toString()),
                    _buildStat('Checked-in', checkedIn.toString()),
                    _buildStat('Remaining', remaining.toString()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Crowd Status', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(value: total == 0 ? 0 : checkedIn / total),
                    const SizedBox(height: 8),
                    Text('Status: $status'),
                    Text('Occupancy: ${percent.toStringAsFixed(1)}%'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) => Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label),
        ],
      );
}