import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  List<String> completedDates; // Format: yyyy-MM-dd

  Habit({
    required this.id,
    required this.name,
    required this.createdAt,
    List<String>? completedDates,
  }) : completedDates = completedDates ?? [];

  bool isCompletedOn(DateTime date) {
    final dateStr = _formatDate(date);
    return completedDates.contains(dateStr);
  }

  void toggleCompletion(DateTime date) {
    final dateStr = _formatDate(date);
    if (completedDates.contains(dateStr)) {
      completedDates.remove(dateStr);
    } else {
      completedDates.add(dateStr);
    }
    save();
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
