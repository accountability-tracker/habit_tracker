import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final themeProvider = StateNotifierProvider<ThemeManager, ThemeMode>((ref) {
  return ThemeManager();
});

class ThemeManager extends StateNotifier<ThemeMode> {
  ThemeManager() : super(ThemeMode.dark);

  void toggleTheme() {
    if (state == ThemeMode.dark) {
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

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    // general
    required this.background,
    required this.background_compliment,
    // navbar
    required this.navbar_background,
    //
    required this.button_affirmative,
    required this.button_negative,
    //
  });
  final Color? background;
  final Color? background_compliment;

  final Color? navbar_background;

  final Color? button_affirmative;
  final Color? button_negative;

  @override
  CustomColors copyWith({
    Color? background,
    Color? background_compliment,
    Color? navbar_background,
    Color? button_affirmative,
    Color? button_negative,
  }) {
    return CustomColors(
      background: background ?? this.background,
      background_compliment:
          background_compliment ?? this.background_compliment,
      navbar_background: navbar_background ?? this.navbar_background,
      button_affirmative: button_affirmative ?? this.button_affirmative,
      button_negative: button_negative ?? this.button_negative,
    );
  }

  // Controls how the properties change on theme changes
  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      background: Color.lerp(background, other.background, t),
      background_compliment:
          Color.lerp(background_compliment, other.background_compliment, t),
      navbar_background:
          Color.lerp(navbar_background, other.navbar_background, t),
      button_affirmative:
          Color.lerp(button_affirmative, other.button_affirmative, t),
      button_negative: Color.lerp(button_negative, other.button_negative, t),
    );
  }

  // Controls how it displays when the instance is being passed
  // to the `print()` method.
  //   @override
  //   String toString() => 'CustomColors('
  //       'success: $success, info: $info, warning: $info, danger: $danger'
  //       ')';
}

final custDarkTheme = ThemeData.dark().copyWith(
  extensions: <ThemeExtension<dynamic>>[
    const CustomColors(
      // general
      background: Color(0xFF201f1E), // .fromRGBO(26, 26, 26, 1.0),
      background_compliment: Color(0xFF252525), //, ff17a2b8),
      // navabar
      navbar_background: Colors.red,
      //
      button_affirmative: Color(0xfff39c12),
      button_negative: Color(0xffe74c3c),
    )
  ],
  useMaterial3: true,
  primaryTextTheme: ThemeData.dark().textTheme.apply(
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
    bodyText2: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
);

final custLightTheme = ThemeData.light().copyWith(
  extensions: <ThemeExtension<dynamic>>[
    const CustomColors(
      // general
      background: Color(0xFFF8F8F8),
      background_compliment: Color.fromRGBO(255, 255, 255, 1.0),
      // navabar
      navbar_background: Colors.blue,
      //
      button_affirmative: Color(0xfff39c12),
      button_negative: Color(0xffe74c3c),
    )
  ],
  useMaterial3: true,
  primaryTextTheme: ThemeData.light().textTheme.apply(
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
  scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
);

///

class ThemeToggleButton extends ConsumerWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        // print("Toggle Theme");
        ref.read(themeProvider.notifier).toggleTheme();
      },
      child: const Text("Toggle Theme"),
    );
  }
}
