import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../widgets/responsive_center.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _idCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _idCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();

    return ResponsiveCenter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Check-in', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(labelText: 'Participant name'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Enter name' : null,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _idCtrl,
                    decoration: const InputDecoration(labelText: 'Participant ID (e.g., 23DIT001)'),
                    validator: (v) => (v == null || v.isEmpty) ? 'Enter ID' : null,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        final result = eventProvider.manualCheckIn(
                          participantName: _nameCtrl.text,
                          participantId: _idCtrl.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.message)),
                        );
                        if (!result.success) return;
                        _nameCtrl.clear();
                        _idCtrl.clear();
                      }
                    },
                    child: const Text('Manual Check-in'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                final result = eventProvider.checkInWithQrPlaceholder();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result.message)),
                );
              },
              icon: const Icon(Icons.qr_code),
              label: const Text('Scan QR (placeholder)'),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Event capacity: ${eventProvider.totalCapacity}'),
                    Text('Checked-in: ${eventProvider.checkedInCount}'),
                    Text('Remaining: ${eventProvider.remaining}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}