import 'package:flutter/material.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      cardTheme: const CardTheme(
        color: Colors.white
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
        ),
      ),
    ),

    AppTheme.darkTheme: ThemeData(
      scaffoldBackgroundColor: Colors.black,
      backgroundColor: Colors.black,
      cardTheme: const CardTheme(
          color: Colors.black
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
      ),
    )
  };
}

enum AppTheme {
  lightTheme,
  darkTheme
}
