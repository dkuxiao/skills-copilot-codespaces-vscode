import 'package:hive/hive.dart';

part 'condition_record.g.dart';

@HiveType(typeId: 2)
class ConditionRecord extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String dateStr; // Format: yyyy-MM-dd

  @HiveField(2)
  double sleepHours;

  @HiveField(3)
  int mood; // 1-5

  @HiveField(4)
  int focus; // 1-5

  @HiveField(5)
  DateTime createdAt;

  ConditionRecord({
    required this.id,
    required this.dateStr,
    required this.sleepHours,
    required this.mood,
    required this.focus,
    required this.createdAt,
  });
}
