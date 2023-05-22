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
    required this.textColorSecondary,
    required this.textColorLink,
    required this.iconDisabled,
    required this.switchColor,
    required this.toggleColor,
    required this.dividerColor,
    // navbar
    required this.navbarBackground,
    required this.navbarSubText,
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
  final Color? textColorSecondary;
  final Color? textColorLink;
  final Color? iconDisabled;
  final Color? switchColor;
  final Color? toggleColor;
  final Color? dividerColor;

  final Color? navbarBackground;
  final Color? navbarSubText;

  final Color? buttonAffirmative;
  final Color? buttonNegative;

  final Color? progressBarBackground;
  final Color? progressBarForeground;

  @override
  CustomColors copyWith({
    Color? background,
    Color? backgroundCompliment,
    Color? textColor,
    Color? textColorSecondary,
    Color? textColorLink,
    Color? iconDisabled,
    Color? switchColor,
    Color? toggleColor,
    Color? dividerColor,
    Color? navbarBackground,
    Color? navbarSubText,
    Color? buttonAffirmative,
    Color? buttonNegative,
    Color? progressBarBackground,
    Color? progressBarForeground,
  }) {
    return CustomColors(
      background: background ?? this.background,
      backgroundCompliment: backgroundCompliment ?? this.backgroundCompliment,
      textColor: textColor ?? this.textColor,
      textColorSecondary: textColorSecondary ?? this.textColorSecondary,
      textColorLink: textColorLink ?? this.textColorLink,
      iconDisabled: iconDisabled ?? this.iconDisabled,
      switchColor: switchColor ?? this.switchColor,
      toggleColor: toggleColor ?? this.toggleColor,
      dividerColor: dividerColor ?? this.dividerColor,
      navbarBackground: navbarBackground ?? this.navbarBackground,
      navbarSubText: navbarSubText ?? this.navbarSubText,
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
      textColorSecondary: Color.lerp(textColorSecondary, other.textColorSecondary, t),
      textColorLink: Color.lerp(textColorLink, other.textColorLink, t),
      iconDisabled: Color.lerp(iconDisabled, other.iconDisabled, t),
      switchColor: Color.lerp(switchColor, other.switchColor, t),
      toggleColor: Color.lerp(toggleColor, other.toggleColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      navbarBackground: Color.lerp(navbarBackground, other.navbarBackground, t),
      navbarSubText: Color.lerp(navbarSubText, other.navbarSubText, t),
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
      background: Color(0xff18171e),
      backgroundCompliment: Color(0xff242430),
      textColor: Color(0xFFFFFFFF),
      textColorSecondary: Color(0xff7c7c86),
      textColorLink: Color(0xff6b6bfc),
      iconDisabled: Color(0xff696969),
      switchColor: Color(0xff521b1b),
      toggleColor: Color(0xffd90000),
      dividerColor: Color(0xff242430),
      // navabar
      navbarBackground: Color(0xff242430),
      navbarSubText: Color(0xff7c7c86),
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
      textColorSecondary: Color(0xff7c7c86),
      textColorLink: Color(0xff6b6bfc),
      iconDisabled: Color(0xff696969),
      switchColor: Color(0xff6b6bfc),
      toggleColor: Color(0xff3010f3),
      dividerColor: Color(0xffe1e1e1),
      // navabar
      navbarBackground: Color(0xff100cc5),
      navbarSubText: Color(0xFFF8F8F8),
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
