import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade700,
    surface: Colors.grey.shade900,
    secondary: Colors.grey.shade800,
    tertiary: Colors.black,
    inversePrimary: Colors.grey.shade200,
  ),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    centerTitle: true,
    titleTextStyle: TextStyle(
        fontSize: 25, color: Colors.grey.shade200, fontWeight: FontWeight.w600),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconSize: const WidgetStatePropertyAll(28),
      iconColor: WidgetStatePropertyAll(
        Colors.grey.shade200,
      ),
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.grey.shade800,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade700,
        )),
  ),
);
