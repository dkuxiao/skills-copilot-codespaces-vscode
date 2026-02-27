import 'package:hive/hive.dart';

part 'pomodoro_settings.g.dart';

@HiveType(typeId: 3)
class PomodoroSettings extends HiveObject {
  @HiveField(0)
  int workDurationMinutes;

  @HiveField(1)
  int breakDurationMinutes;

  PomodoroSettings({
    this.workDurationMinutes = 25,
    this.breakDurationMinutes = 5,
  });
}
