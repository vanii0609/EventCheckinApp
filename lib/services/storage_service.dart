import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _boxName = 'event_state_box';
  static const String _stateKey = 'state';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<Map>(_boxName);
  }

  Box<Map> get _box => Hive.box<Map>(_boxName);

  Map<String, dynamic> readState() {
    final raw = _box.get(_stateKey);
    if (raw == null) return <String, dynamic>{};
    return Map<String, dynamic>.from(raw);
  }

  Future<void> writeState(Map<String, dynamic> state) async {
    await _box.put(_stateKey, state);
  }

  Future<void> clearState() async {
    await _box.delete(_stateKey);
  }

  Future<String> syncDummy() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return 'Data synced locally (dummy sync only).';
  }
}