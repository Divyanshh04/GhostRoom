import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xFF09090B);
  static const Color primary = Color(0xFF8B5CF6);
  static const Color secondary = Color(0xFFA855F7);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    scaffoldBackgroundColor: background,

    colorScheme: ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: const Color(0xFF111113),
    ),

    fontFamily: 'Roboto',

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(
          color: primary,
          width: 1.5,
        ),
        minimumSize: const Size(double.infinity, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),
  );
}