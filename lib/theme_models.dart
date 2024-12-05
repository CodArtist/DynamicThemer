import 'package:flutter/material.dart';

class AppThemes {
  static late ThemeData lightTheme;
  static late ThemeData darkTheme;
  static late Gradient lightGradient;
  static late Gradient darkGradient;

  /// Initializes themes and gradients with provided or default values
  static void initialize({
    ThemeData? lightThemeData,
    ThemeData? darkThemeData,
    Gradient? lightGradientData,
    Gradient? darkGradientData,
  }) {
    lightTheme = lightThemeData ??
        ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white, // Text color
            elevation: 0,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
          ),
        );

    darkTheme = darkThemeData ??
        ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white, // Text color
            elevation: 0,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
          ),
        );

    lightGradient = lightGradientData ??
        const LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    darkGradient = darkGradientData ??
        const LinearGradient(
          colors: [Color(0xff0D324D), Color(0xff7F5A83)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
  }
}
