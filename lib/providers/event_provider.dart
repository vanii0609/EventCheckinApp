import 'package:flutter/foundation.dart';

import '../models/check_in_log_model.dart';
import '../models/event_model.dart';
import '../models/participant_model.dart';

class ActionResult {
  const ActionResult({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;
}

class EventProvider extends ChangeNotifier {
  EventModel? _event;

  final List<ParticipantModel> _participants = [
    const ParticipantModel(id: '23DIT023', name: 'Rahul Parekh'),
    const ParticipantModel(id: '23DIT1045', name: 'Priya Shah'),
    const ParticipantModel(id: '23DIT1088', name: 'Amit Kumar'),
    const ParticipantModel(id: '23DIT1101', name: 'Sneha Reddy'),
  ];

  final Set<String> _checkedInIds = <String>{};
  final List<CheckInLogModel> _logs = [];

  EventModel? get event => _event;
  List<ParticipantModel> get participants => List.unmodifiable(_participants);
  List<CheckInLogModel> get logs => List.unmodifiable(_logs);

  int get checkedInCount => _checkedInIds.length;
  int get totalCapacity => _event?.capacity ?? 0;
  int get remaining => (totalCapacity - checkedInCount).clamp(0, 999999);
  double get occupancy => totalCapacity == 0 ? 0 : checkedInCount / totalCapacity;

  String get crowdStatus {
    if (occupancy < 0.60) return 'Safe';
    if (occupancy < 0.90) return 'Moderate';
    return 'Full';
  }

  bool isCheckedIn(String id) => _checkedInIds.contains(id.toUpperCase());

  void createEvent({
    required String name,
    required int capacity,
    required DateTime date,
  }) {
    _event = EventModel(name: name.trim(), capacity: capacity, date: date);
    notifyListeners();
  }

  ActionResult manualCheckIn({
    required String participantName,
    required String participantId,
  }) {
    if (_event == null) {
      return const ActionResult(
        success: false,
        message: 'Please create event first in Event Setup.',
      );
    }

    if (checkedInCount >= totalCapacity) {
      return const ActionResult(
        success: false,
        message: 'Event is full. No more check-ins allowed.',
      );
    }

    final id = participantId.trim().toUpperCase();
    final name = participantName.trim();

    if (id.isEmpty || name.isEmpty) {
      return const ActionResult(
        success: false,
        message: 'Name and participant ID are required.',
      );
    }

    if (_checkedInIds.contains(id)) {
      return ActionResult(
        success: false,
        message: '$id is already checked in.',
      );
    }

    final existing = _participants.where((p) => p.id == id).toList();
    if (existing.isEmpty) {
      _participants.add(ParticipantModel(id: id, name: name));
    }

    _checkedInIds.add(id);
    _logs.insert(
      0,
      CheckInLogModel(
        participantId: id,
        participantName: name,
        time: DateTime.now(),
      ),
    );

    notifyListeners();
    return ActionResult(
      success: true,
      message: 'Check-in successful for $name ($id).',
    );
  }

  ActionResult checkInWithQrPlaceholder() {
    final pending = _participants.firstWhere(
      (p) => !_checkedInIds.contains(p.id),
      orElse: () => const ParticipantModel(id: '', name: ''),
    );

    if (pending.id.isEmpty) {
      return const ActionResult(
        success: false,
        message: 'No pending participant found for QR placeholder.',
      );
    }

    return manualCheckIn(
      participantName: pending.name,
      participantId: pending.id,
    );
  }
}