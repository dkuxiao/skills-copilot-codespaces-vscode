import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/condition_provider.dart';

class ConditionScreen extends ConsumerStatefulWidget {
  const ConditionScreen({super.key});

  @override
  ConsumerState<ConditionScreen> createState() => _ConditionScreenState();
}

class _ConditionScreenState extends ConsumerState<ConditionScreen> {
  double _sleepHours = 7.0;
  int _mood = 3;
  int _focus = 3;

  @override
  void initState() {
    super.initState();
    // Load existing condition if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final condition = ref.read(conditionProvider);
      if (condition != null) {
        setState(() {
          _sleepHours = condition.sleepHours;
          _mood = condition.mood;
          _focus = condition.focus;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Condition'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),

            // Sleep Hours
            _buildSectionTitle('Sleep Hours'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _sleepHours,
                    min: 0,
                    max: 12,
                    divisions: 24,
                    label: _sleepHours.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() => _sleepHours = value);
                    },
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Text(
                    '${_sleepHours.toStringAsFixed(1)}h',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Mood
            _buildSectionTitle('Mood'),
            const SizedBox(height: 16),
            _buildRatingButtons(_mood, (value) {
              setState(() => _mood = value);
            }),
            const SizedBox(height: 32),

            // Focus Level
            _buildSectionTitle('Focus Level'),
            const SizedBox(height: 16),
            _buildRatingButtons(_focus, (value) {
              setState(() => _focus = value);
            }),
            const SizedBox(height: 48),

            // Save Button
            ElevatedButton(
              onPressed: _saveCondition,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildRatingButtons(int currentValue, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(5, (index) {
        final value = index + 1;
        final isSelected = value == currentValue;

        return InkWell(
          onTap: () => onChanged(value),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF6C7A89)
                  : Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF6C7A89)
                    : Colors.grey[700]!,
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[400],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _saveCondition() {
    ref.read(conditionProvider.notifier).saveCondition(
          sleepHours: _sleepHours,
          mood: _mood,
          focus: _focus,
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Condition saved'),
        duration: Duration(seconds: 2),
      ),
    );

    context.pop();
  }
}
