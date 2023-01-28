// import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
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
    required this.backgroundCompliment,
    required this.textColor,
    // navbar
    required this.navbarBackground,
    //
    required this.buttonAffirmative,
    required this.buttonNegative,
    // progress bars
    required this.progressBarBackground,
    required this.progressBarForeground,
  });
  final Color? background;
  final Color? backgroundCompliment;
  final Color? textColor;

  final Color? navbarBackground;

  final Color? buttonAffirmative;
  final Color? buttonNegative;

  final Color? progressBarBackground;
  final Color? progressBarForeground;

  @override
  CustomColors copyWith({
    Color? background,
    Color? backgroundCompliment,
    Color? textColor,
    Color? navbarBackground,
    Color? buttonAffirmative,
    Color? buttonNegative,
    Color? progressBarBackground,
    Color? progressBarForeground,
  }) {
    return CustomColors(
      background: background ?? this.background,
      backgroundCompliment: backgroundCompliment ?? this.backgroundCompliment,
      textColor: textColor ?? this.textColor,
      navbarBackground: navbarBackground ?? this.navbarBackground,
      buttonAffirmative: buttonAffirmative ?? this.buttonAffirmative,
      buttonNegative: buttonNegative ?? this.buttonNegative,
      progressBarBackground: progressBarBackground ?? this.progressBarBackground,
      progressBarForeground: progressBarForeground ?? this.progressBarForeground,
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
      backgroundCompliment: Color.lerp(backgroundCompliment, other.backgroundCompliment, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      navbarBackground: Color.lerp(navbarBackground, other.navbarBackground, t),
      buttonAffirmative: Color.lerp(buttonAffirmative, other.buttonAffirmative, t),
      buttonNegative: Color.lerp(buttonNegative, other.buttonNegative, t),
      progressBarBackground: Color.lerp(progressBarBackground, other.progressBarBackground, t),
      progressBarForeground: Color.lerp(progressBarForeground, other.progressBarForeground, t),
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
      background: Color(0xFF111111),
      backgroundCompliment: Color(0xFF1E1E1E),
      textColor: Color(0xFFFFFFFF),
      // navabar
      navbarBackground: Color(0xFF1E1E1E),
      //
      buttonAffirmative: Color(0xfff39c12),
      buttonNegative: Color(0xffe74c3c),
      // progress_bar
      progressBarBackground: Color.fromARGB(255, 27, 20, 20),
      progressBarForeground: Color.fromARGB(255, 83, 109, 209),
    )
  ],
  useMaterial3: true,
  primaryTextTheme: ThemeData.dark().textTheme.apply(
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
    bodyMedium: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
  ),
  scaffoldBackgroundColor: const Color.fromRGBO(26, 26, 26, 1.0),
);

final custLightTheme = ThemeData.light().copyWith(
  extensions: <ThemeExtension<dynamic>>[
    const CustomColors(
      // general
      background: Color(0xFFF8F8F8),
      backgroundCompliment: Color.fromRGBO(255, 255, 255, 1.0),
      textColor: Color(0xFF000000),
      // navabar
      navbarBackground: Color(0xFF053a7a),
      //
      buttonAffirmative: Color(0xfff39c12),
      buttonNegative: Color(0xffe74c3c),
      // progress_bar
      progressBarBackground: Color(0xFFF1F1F1),
      progressBarForeground: Color(0xFF254CFF),
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
