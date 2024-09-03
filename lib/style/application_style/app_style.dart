import 'package:flutter/material.dart';

class AppStyle
{
  static Color lightPrimaryColor = const Color(0xff5D9CEC);
  static Color lightTextColor = const Color(0xff383838);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    appBarTheme: AppBarTheme(
      color: lightPrimaryColor,
      toolbarHeight: 110,
      titleTextStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w700
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white
      )
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightPrimaryColor,
      shape: const StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 3
        )
      )
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: lightPrimaryColor,
        primary: lightPrimaryColor
    ),
    textTheme: TextTheme(
      labelSmall: const TextStyle(color: Colors.white, fontSize: 15),
      titleLarge: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: lightPrimaryColor)
    ),
    useMaterial3: false,
  );
}