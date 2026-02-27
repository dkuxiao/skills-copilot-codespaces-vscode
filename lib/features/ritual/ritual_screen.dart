import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RitualScreen extends StatefulWidget {
  const RitualScreen({super.key});

  @override
  State<RitualScreen> createState() => _RitualScreenState();
}

class _RitualScreenState extends State<RitualScreen> {
  int _countdown = 30;
  bool _isActive = false;
  Timer? _timer;
  int _breathPhase = 0; // 0: inhale, 1: hold, 2: exhale

  final List<String> _breathInstructions = [
    'Breathe in...',
    'Hold...',
    'Breathe out...',
  ];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startRitual() {
    setState(() {
      _isActive = true;
      _countdown = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
          // Change breath phase every 4 seconds
          if (_countdown % 4 == 0) {
            _breathPhase = (_breathPhase + 1) % 3;
          }
        } else {
          _timer?.cancel();
          _isActive = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white54),
                onPressed: () => context.pop(),
              ),
            ),

            // Main content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_isActive)
                      Column(
                        children: [
                          const Text(
                            'Eye Focus Ritual',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Focus on the dot\nBreathe deeply\nRelax your mind',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                              height: 1.8,
                            ),
                          ),
                          const SizedBox(height: 48),
                          ElevatedButton(
                            onPressed: _startRitual,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white12,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 16,
                              ),
                            ),
                            child: const Text('Begin'),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          // The dot
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(height: 80),

                          // Breathing instruction
                          Text(
                            _breathInstructions[_breathPhase],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // Countdown
                          Text(
                            '$_countdown',
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 48,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ],
                      ),

                    // Completion
                    if (!_isActive && _countdown == 0) ...[
                      const SizedBox(height: 48),
                      const Text(
                        'Ritual Complete',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context.pop();
                          context.push('/focus');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C7A89),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('Start Focus Session'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
