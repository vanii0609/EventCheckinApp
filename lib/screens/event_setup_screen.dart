import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/event_provider.dart';
import '../widgets/responsive_center.dart';

class EventSetupScreen extends StatefulWidget {
  const EventSetupScreen({super.key});

  @override
  State<EventSetupScreen> createState() => _EventSetupScreenState();
}

class _EventSetupScreenState extends State<EventSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController(text: 'Tech Fest 2026');
  final _capacityCtrl = TextEditingController(text: '250');
  DateTime? _eventDate;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _capacityCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _eventDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventProvider>();

    return ResponsiveCenter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Event Setup', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Event name'),
                validator: (v) => (v == null || v.isEmpty) ? 'Enter event name' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _capacityCtrl,
                decoration: const InputDecoration(labelText: 'Capacity'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Enter capacity';
                  if (int.tryParse(v) == null) return 'Enter a number';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(_eventDate == null ? 'No date chosen' : _eventDate!.toLocal().toString().split(' ')[0]),
                  ),
                  ElevatedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Pick date'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    eventProvider.createEvent(
                      name: _nameCtrl.text,
                      capacity: int.parse(_capacityCtrl.text),
                      date: _eventDate ?? DateTime.now(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Event saved successfully.')),
                    );
                  }
                },
                child: const Text('Save Event'),
              ),
              const SizedBox(height: 16),
              if (eventProvider.event != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Current Event'),
                        const SizedBox(height: 6),
                        Text('Name: ${eventProvider.event!.name}'),
                        Text('Capacity: ${eventProvider.event!.capacity}'),
                        Text('Checked-in: ${eventProvider.checkedInCount}'),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}