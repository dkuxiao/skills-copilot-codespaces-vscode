import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TimerStatus { idle, running, paused }

class PomodoroState {
  final int remainingSeconds;
  final TimerStatus status;
  final int workDuration;

  PomodoroState({
    required this.remainingSeconds,
    required this.status,
    required this.workDuration,
  });

  PomodoroState copyWith({
    int? remainingSeconds,
    TimerStatus? status,
    int? workDuration,
  }) {
    return PomodoroState(
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      status: status ?? this.status,
      workDuration: workDuration ?? this.workDuration,
    );
  }
}

final pomodoroProvider = StateNotifierProvider<PomodoroNotifier, PomodoroState>((ref) {
  return PomodoroNotifier();
});

class PomodoroNotifier extends StateNotifier<PomodoroState> {
  PomodoroNotifier()
      : super(PomodoroState(
          remainingSeconds: 25 * 60,
          status: TimerStatus.idle,
          workDuration: 25,
        ));

  Timer? _timer;

  void start() {
    if (state.status == TimerStatus.running) return;

    state = state.copyWith(status: TimerStatus.running);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds > 0) {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      } else {
        // Timer completed
        stop();
        // TODO: Trigger notification
      }
    });
  }

  void pause() {
    _timer?.cancel();
    state = state.copyWith(status: TimerStatus.paused);
  }

  void stop() {
    _timer?.cancel();
    state = state.copyWith(
      status: TimerStatus.idle,
      remainingSeconds: state.workDuration * 60,
    );
  }

  void reset() {
    _timer?.cancel();
    state = PomodoroState(
      remainingSeconds: state.workDuration * 60,
      status: TimerStatus.idle,
      workDuration: state.workDuration,
    );
  }

  void setDuration(int minutes) {
    if (state.status != TimerStatus.idle) return;
    state = PomodoroState(
      remainingSeconds: minutes * 60,
      status: TimerStatus.idle,
      workDuration: minutes,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
