import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: const Color(0xff20488f),
  scaffoldBackgroundColor: const Color(0xFFE0F2F1),
  colorScheme: const ColorScheme.light().copyWith(
    secondary: Colors.white
  ),
  fontFamily: 'Raleway',
  textTheme: ThemeData.light().textTheme.copyWith(
      headline5: const TextStyle(
        fontSize: 20,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
      ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);