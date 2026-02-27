import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/daily_goals_provider.dart';
import '../../providers/habits_provider.dart';
import '../../providers/condition_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(dailyGoalsProvider);
    final habits = ref.watch(habitsProvider);
    final condition = ref.watch(conditionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus App'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Condition Button
            _buildConditionCard(context, condition),
            const SizedBox(height: 24),

            // Focus Actions
            _buildFocusActions(context),
            const SizedBox(height: 24),

            // Today's Goals
            _buildGoalsSection(context, ref, goals),
            const SizedBox(height: 24),

            // Habits
            _buildHabitsSection(context, ref, habits),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionCard(BuildContext context, ConditionRecord? condition) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/condition'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today\'s Condition',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              if (condition != null)
                Text(
                  'Sleep: ${condition.sleepHours}h | Mood: ${condition.mood}/5 | Focus: ${condition.focus}/5',
                  style: TextStyle(color: Colors.grey[400]),
                )
              else
                Text(
                  'Tap to record your condition',
                  style: TextStyle(color: Colors.grey[500]),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFocusActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.push('/ritual'),
            icon: const Icon(Icons.remove_red_eye_outlined),
            label: const Text('Ritual'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.push('/focus'),
            icon: const Icon(Icons.timer_outlined),
            label: const Text('Focus'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoalsSection(BuildContext context, WidgetRef ref, List goals) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today\'s Goals',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () => _showAddGoalDialog(context, ref),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (goals.isEmpty)
              Text(
                'No goals set for today',
                style: TextStyle(color: Colors.grey[500]),
              )
            else
              ...goals.map((goal) => CheckboxListTile(
                    title: Text(goal.text),
                    value: goal.isCompleted,
                    onChanged: (_) {
                      ref.read(dailyGoalsProvider.notifier).toggleGoal(goal.id);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitsSection(BuildContext context, WidgetRef ref, List habits) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Habits',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: const Icon(Icons.settings, size: 20),
                  onPressed: () => context.push('/habits'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (habits.isEmpty)
              Text(
                'No habits created yet',
                style: TextStyle(color: Colors.grey[500]),
              )
            else
              ...habits.map((habit) {
                final isCompleted = habit.isCompletedOn(DateTime.now());
                return CheckboxListTile(
                  title: Text(habit.name),
                  value: isCompleted,
                  onChanged: (_) {
                    ref
                        .read(habitsProvider.notifier)
                        .toggleHabitCompletion(habit.id, DateTime.now());
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                );
              }),
          ],
        ),
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Goal'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter your goal',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(dailyGoalsProvider.notifier).addGoal(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
