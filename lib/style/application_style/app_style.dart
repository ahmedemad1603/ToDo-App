import 'package:flutter/material.dart';

class AppStyle
{
  static Color lightPrimaryColor = const Color(0xff5D9CEC);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    appBarTheme: AppBarTheme(
      color: lightPrimaryColor,
      toolbarHeight: 110,
      titleTextStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w700
      )
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: lightPrimaryColor,
        primary: lightPrimaryColor
    ),
    textTheme: const TextTheme(
      labelSmall: TextStyle(color: Colors.white, fontSize: 15)
    ),
    useMaterial3: true,
  );
}