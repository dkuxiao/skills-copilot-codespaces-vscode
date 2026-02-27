import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/condition_record.dart';
import '../utils/date_helpers.dart';

final conditionProvider = StateNotifierProvider<ConditionNotifier, ConditionRecord?>((ref) {
  return ConditionNotifier();
});

class ConditionNotifier extends StateNotifier<ConditionRecord?> {
  ConditionNotifier() : super(null) {
    _loadTodaysCondition();
  }

  Box<ConditionRecord>? _conditionBox;

  Future<void> _loadTodaysCondition() async {
    _conditionBox = await Hive.openBox<ConditionRecord>('conditions');
    final today = formatDate(DateTime.now());
    final todaysCondition = _conditionBox!.values
        .where((record) => record.dateStr == today)
        .firstOrNull;
    state = todaysCondition;
  }

  Future<void> saveCondition({
    required double sleepHours,
    required int mood,
    required int focus,
  }) async {
    if (_conditionBox == null) return;

    final today = formatDate(DateTime.now());

    // Delete existing record for today if exists
    if (state != null) {
      await state!.delete();
    }

    final record = ConditionRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      dateStr: today,
      sleepHours: sleepHours,
      mood: mood,
      focus: focus,
      createdAt: DateTime.now(),
    );

    await _conditionBox!.add(record);
    state = record;
  }
}
