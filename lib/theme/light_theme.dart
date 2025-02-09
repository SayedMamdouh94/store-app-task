import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
      primary: Colors.grey.shade500,
      surface: Colors.grey.shade300,
      secondary: Colors.grey.shade100,
      tertiary: Colors.white,
      inversePrimary: Colors.grey.shade700),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
        fontSize: 25, color: Colors.grey.shade700, fontWeight: FontWeight.w600),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconSize: const WidgetStatePropertyAll(28),
      iconColor: WidgetStatePropertyAll(
        Colors.grey.shade700,
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.grey.shade100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Colors.grey.shade700,
      ),
    ),
  ),
);
