import 'package:hive/hive.dart';

part 'daily_goal.g.dart';

@HiveType(typeId: 1)
class DailyGoal extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String dateStr; // Format: yyyy-MM-dd

  @HiveField(2)
  String text;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  DateTime createdAt;

  DailyGoal({
    required this.id,
    required this.dateStr,
    required this.text,
    this.isCompleted = false,
    required this.createdAt,
  });

  void toggle() {
    isCompleted = !isCompleted;
    save();
  }
}
