import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[500]!,
    ),
    colorScheme: ColorScheme.light(
      background: Colors.grey[700]!,
      primary: Colors.grey[400]!,
      secondary: Colors.grey[300]!,
      tertiary: Colors.black,
    ));
