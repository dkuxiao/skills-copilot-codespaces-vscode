import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/pomodoro_provider.dart';
import '../../utils/date_helpers.dart';

class FocusScreen extends ConsumerWidget {
  const FocusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pomodoroState = ref.watch(pomodoroProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Focus'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showDurationSettings(context, ref),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer Display
            Text(
              formatTime(pomodoroState.remainingSeconds),
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w300,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 48),

            // Status
            Text(
              _getStatusText(pomodoroState.status),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 48),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (pomodoroState.status == TimerStatus.idle)
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(pomodoroProvider.notifier).start();
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                if (pomodoroState.status == TimerStatus.running)
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(pomodoroProvider.notifier).pause();
                    },
                    icon: const Icon(Icons.pause),
                    label: const Text('Pause'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                if (pomodoroState.status == TimerStatus.paused)
                  ElevatedButton.icon(
                    onPressed: () {
                      ref.read(pomodoroProvider.notifier).start();
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Resume'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                if (pomodoroState.status != TimerStatus.idle) ...[
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      ref.read(pomodoroProvider.notifier).reset();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(TimerStatus status) {
    switch (status) {
      case TimerStatus.idle:
        return 'Ready to focus';
      case TimerStatus.running:
        return 'Focusing...';
      case TimerStatus.paused:
        return 'Paused';
    }
  }

  void _showDurationSettings(BuildContext context, WidgetRef ref) {
    final pomodoroState = ref.read(pomodoroProvider);
    int selectedMinutes = pomodoroState.workDuration;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Duration'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$selectedMinutes minutes',
                style: const TextStyle(fontSize: 24),
              ),
              Slider(
                value: selectedMinutes.toDouble(),
                min: 5,
                max: 60,
                divisions: 11,
                label: '$selectedMinutes min',
                onChanged: (value) {
                  setState(() {
                    selectedMinutes = value.toInt();
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(pomodoroProvider.notifier).setDuration(selectedMinutes);
              Navigator.pop(context);
            },
            child: const Text('Set'),
          ),
        ],
      ),
    );
  }
}
