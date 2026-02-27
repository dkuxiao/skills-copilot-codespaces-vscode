import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/habit.dart';
import '../utils/date_helpers.dart';

final habitsProvider = StateNotifierProvider<HabitsNotifier, List<Habit>>((ref) {
  return HabitsNotifier();
});

class HabitsNotifier extends StateNotifier<List<Habit>> {
  HabitsNotifier() : super([]) {
    _loadHabits();
  }

  Box<Habit>? _habitsBox;

  Future<void> _loadHabits() async {
    _habitsBox = await Hive.openBox<Habit>('habits');
    state = _habitsBox!.values.toList();
  }

  Future<void> addHabit(String name) async {
    if (_habitsBox == null) return;

    final habit = Habit(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      createdAt: DateTime.now(),
    );

    await _habitsBox!.add(habit);
    state = [...state, habit];
  }

  Future<void> deleteHabit(String id) async {
    if (_habitsBox == null) return;

    final habit = state.firstWhere((h) => h.id == id);
    await habit.delete();
    state = state.where((h) => h.id != id).toList();
  }

  void toggleHabitCompletion(String id, DateTime date) {
    final habitIndex = state.indexWhere((h) => h.id == id);
    if (habitIndex == -1) return;

    state[habitIndex].toggleCompletion(date);
    state = [...state];
  }

  List<Habit> getTodaysHabits() {
    return state;
  }

  bool isHabitCompletedToday(String id) {
    final habit = state.firstWhere((h) => h.id == id);
    return habit.isCompletedOn(DateTime.now());
  }
}
