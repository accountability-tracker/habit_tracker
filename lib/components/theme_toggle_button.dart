import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:habit_tracker/theme.dart';

class ThemeToggleButton extends ConsumerStatefulWidget {
  const ThemeToggleButton({super.key});

  @override
  ConsumerState<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends ConsumerState<ThemeToggleButton> {
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Future<void> _incrementCounter() async {
  //   final SharedPreferences prefs = await _prefs;
  //   final int counter = (prefs.getInt('counter') ?? 0) + 1;

  //   setState(() {
  //     _counter = prefs.setInt('counter', counter).then((bool success) {
  //       return counter;
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();

  //   _counter = _prefs.then((SharedPreferences prefs) {
  //       var x = prefs.getString('theme');

  //       if(theme == "light") {
  //         return ThemeMode.light
  //       }

  //       return ThemeMode.dark;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final ThemeMode tm = ref.watch(themeProvider);

    return Row(
      children: <Widget>[
        if (ref.watch(themeProvider) == ThemeMode.dark) ...[
          IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ] else if (ref.watch(themeProvider) == ThemeMode.light) ...[
          IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ],
    );
  }
}
