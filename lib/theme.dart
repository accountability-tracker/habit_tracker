import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeManager, ThemeMode>((ref) {
    return ThemeManager();
});

class ThemeManager extends StateNotifier<ThemeMode> {
  ThemeManager(): super(ThemeMode.dark);

  void toggleTheme() {
    if(state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }

  void setLightMode() {
    state = ThemeMode.light;
  }

  void setDarkMode() {
    state = ThemeMode.dark;
  }
}

///

final cust_darkTheme = ThemeData(
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Color.fromRGBO(26, 26, 26, 1.0),

  textTheme: const TextTheme(
     bodyText1: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
     bodyText2: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
  ),
);

final cust_lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
);

///

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        print("Toggle Theme");
        ref.read(themeProvider.notifier).toggleTheme();
      },

      child: Text("Toggle Theme"),
    );
  }
}
