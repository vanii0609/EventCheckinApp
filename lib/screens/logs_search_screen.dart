import 'package:flutter/material.dart';

import '../widgets/responsive_center.dart';

class LogsSearchScreen extends StatefulWidget {
  const LogsSearchScreen({super.key});

  @override
  State<LogsSearchScreen> createState() => _LogsSearchScreenState();
}

class _LogsSearchScreenState extends State<LogsSearchScreen> {
  final _searchCtrl = TextEditingController();

  final List<Map<String, String>> _sample = [
    {'name': 'Palak Sankharva', 'id': '23DIT065', 'time': '10:02 AM'},
    {'name': 'Dhani Patel', 'id': '23DIT042', 'time': '10:05 AM'},
    {'name': 'Vani Makadia', 'id': '23DIT031', 'time': '10:12 AM'},
    {'name': 'Esha Patel', 'id': '23DIT043', 'time': '10:20 AM'},
  ];

  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _sample.where((e) {
      final q = _query.toLowerCase();
      return e['name']!.toLowerCase().contains(q) || e['id']!.toLowerCase().contains(q);
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
                    title: Text(item['name']!),
                    subtitle: Text('${item['id']} • ${item['time']}'),
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