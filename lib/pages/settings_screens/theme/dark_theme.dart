import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff89b4fa),
    ),
    colorScheme: ColorScheme.dark(
      background: Color(0xff1e1e2e),
      primary: Color(0xff89b4fa),
      secondary: Color(0xffb4befe),
      tertiary: Color(0xff89dceb),
      onPrimary: Color(0xff11111b),
      onBackground: Color(0xffcdd6f4),
      onSurfaceVariant: Color(0xff313244),
    ));
