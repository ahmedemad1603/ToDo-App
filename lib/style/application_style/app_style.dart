import 'package:flutter/material.dart';

class AppStyle
{
  static Color lightPrimaryColor = const Color(0xff5D9CEC);

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: lightPrimaryColor,
        primary: lightPrimaryColor
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(color: Colors.white, fontSize: 15)
    ),
    useMaterial3: true,
  );
}