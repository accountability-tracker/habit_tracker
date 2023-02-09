import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/calorie_tracker/index.dart';

import 'package:habit_tracker/habit_tracker/index.dart';

import 'package:habit_tracker/theme.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HabitTrackerHome(
          title: "Habit Tracker",
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'calorie-tracker',
          builder: (BuildContext context, GoRouterState state) {
            return const CalorieTrackerHome(title: "Calorie Tracker");
          },
        ),
      ],
    ),
  ],
);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode tm = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Habit App',
      debugShowCheckedModeBanner: false,
      theme: custLightTheme,
      darkTheme: custDarkTheme,
      themeMode: tm,
      // home: const MyHomePage(title: 'Habits view'),
      routerConfig: _router,
    );
  }
}
