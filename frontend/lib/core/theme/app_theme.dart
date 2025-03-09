import 'package:flutter/material.dart';
import 'text_styles.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade800,
      secondary: Colors.blueAccent,
      surface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade800,
      titleTextStyle: TextStyles.headlineMedium.copyWith(color: Colors.white),
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyles.headlineMedium,
      bodyLarge: TextStyles.bodyText1,
      bodyMedium: TextStyles.bodyText2,
      labelSmall: TextStyles.caption,
      labelLarge: TextStyles.button,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Colors.blue.shade300,
      secondary: Colors.lightBlueAccent,
      surface: Colors.grey.shade900,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade900,
      titleTextStyle: TextStyles.headlineMedium.copyWith(color: Colors.white),
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyles.headlineMedium.copyWith(color: Colors.white),
      bodyLarge: TextStyles.bodyText1.copyWith(color: Colors.white70),
      bodyMedium: TextStyles.bodyText2.copyWith(color: Colors.white60),
      labelSmall: TextStyles.caption.copyWith(color: Colors.white38),
      labelLarge: TextStyles.button.copyWith(color: Colors.white),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      color: Colors.grey.shade800, // Moved out from inside `shape`
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
    ),
  );
}
