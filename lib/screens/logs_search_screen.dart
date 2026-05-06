import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../widgets/responsive_center.dart';

class LogsSearchScreen extends StatefulWidget {
  const LogsSearchScreen({super.key});

  @override
  State<LogsSearchScreen> createState() => _LogsSearchScreenState();
}

class _LogsSearchScreenState extends State<LogsSearchScreen> {
  final _searchCtrl = TextEditingController();

  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logs = context.watch<EventProvider>().logs;

    final filtered = logs.where((e) {
      final q = _query.toLowerCase();
      return e.participantName.toLowerCase().contains(q) ||
          e.participantId.toLowerCase().contains(q);
    }).toList();

    return ResponsiveCenter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Logs & Search', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            TextField(
              controller: _searchCtrl,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search by name or ID'),
              onChanged: (v) => setState(() => _query = v),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final item = filtered[i];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(item.participantName),
                    subtitle: Text(
                      '${item.participantId} • ${DateFormat('dd MMM, hh:mm a').format(item.time)}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}