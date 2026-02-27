import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/daily_goal.dart';
import '../utils/date_helpers.dart';

final dailyGoalsProvider = StateNotifierProvider<DailyGoalsNotifier, List<DailyGoal>>((ref) {
  return DailyGoalsNotifier();
});

class DailyGoalsNotifier extends StateNotifier<List<DailyGoal>> {
  DailyGoalsNotifier() : super([]) {
    _loadGoals();
  }

  Box<DailyGoal>? _goalsBox;

  Future<void> _loadGoals() async {
    _goalsBox = await Hive.openBox<DailyGoal>('daily_goals');
    final today = formatDate(DateTime.now());
    state = _goalsBox!.values.where((goal) => goal.dateStr == today).toList();
  }

  Future<void> addGoal(String text) async {
    if (_goalsBox == null) return;

    final goal = DailyGoal(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      dateStr: formatDate(DateTime.now()),
      text: text,
      createdAt: DateTime.now(),
    );

    await _goalsBox!.add(goal);
    state = [...state, goal];
  }

  Future<void> deleteGoal(String id) async {
    if (_goalsBox == null) return;

    final goal = state.firstWhere((g) => g.id == id);
    await goal.delete();
    state = state.where((g) => g.id != id).toList();
  }

  void toggleGoal(String id) {
    final goalIndex = state.indexWhere((g) => g.id == id);
    if (goalIndex == -1) return;

    state[goalIndex].toggle();
    state = [...state];
  }
}
