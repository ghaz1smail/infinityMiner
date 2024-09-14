import 'package:flutter/material.dart';

class AppTheme {
  Color primaryColor = const Color(0xff1A4D2E),
      secondoryColor = const Color(0xffFF9F29),
      backgroundColor = Colors.black;

  ThemeData theme = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: const Color(0xff1A4D2E),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xff1A4D2E),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ));
}
