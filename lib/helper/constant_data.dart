import 'package:flutter/material.dart';
import 'package:infinityminer/admin/admin_acreen.dart';
import 'package:infinityminer/view/register/forget_screen.dart';
import 'package:infinityminer/view/register/register_screen.dart';
import 'package:infinityminer/view/screens/splash_screen.dart';
import 'package:infinityminer/view/user/user_screen.dart';

class AppConstant {
  final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
  final RegExp isArabic =
      RegExp(r'[\u0600-\u06FF\u0750-\u077F\uFB50-\uFDFF\uFE70-\uFEFF]');

  Color primaryColor = const Color(0xffffbd59), secondryColor = Colors.black;

  List<BoxShadow> shadow = [
    const BoxShadow(
      color: Colors.black26,
      spreadRadius: 0.1,
      blurRadius: 5,
    ),
  ];

  Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashScreen(),
    '/log_in': (context) => const RegisterScreen(),
    '/admin': (context) => const AdminScreen(),
    '/forgot_password': (context) => const ForgetScreen(),
    '/user': (context) => const UserScreen(),
  };

  ThemeData theme = ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: const Color(0xffffbd59),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xffffbd59),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));
}
