import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/focus/focus_screen.dart';
import '../features/ritual/ritual_screen.dart';
import '../features/habits/habits_screen.dart';
import '../features/condition/condition_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/focus',
      builder: (context, state) => const FocusScreen(),
    ),
    GoRoute(
      path: '/ritual',
      builder: (context, state) => const RitualScreen(),
    ),
    GoRoute(
      path: '/habits',
      builder: (context, state) => const HabitsScreen(),
    ),
    GoRoute(
      path: '/condition',
      builder: (context, state) => const ConditionScreen(),
    ),
  ],
);
