import 'package:flutter/material.dart';

import 'custom_transition_builder.dart';

var primaryColor = const Color(0xff20488f);

final theme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: const Color(0xFFE0F2F1),
  colorScheme: const ColorScheme.light(primary: Colors.blue),
  dividerColor: Colors.black,
  appBarTheme: ThemeData.light().appBarTheme.copyWith(
    color: primaryColor,
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
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomTransitionBuilder(),
      TargetPlatform.iOS: CustomTransitionBuilder(),
      TargetPlatform.macOS: CustomTransitionBuilder(),
      TargetPlatform.windows: CustomTransitionBuilder(),
      TargetPlatform.linux: CustomTransitionBuilder(),
    },
  ),
);