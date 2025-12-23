import 'package:flutter/material.dart';

class AppColorScheme {
  final Color primary;
  final Color appBarBackground;
  final Color scaffoldBackgroundColor;
  final Color textBtnColor;
  final Color cardColor;
  final Color cardSurfaceTintColor;
  final Color cardShadowColor;
  final Color textColor;
  AppColorScheme(
      {required this.primary,
      required this.appBarBackground,
      required this.scaffoldBackgroundColor,
      required this.textBtnColor,
      required this.cardColor,
      required this.cardSurfaceTintColor,
      required this.cardShadowColor,
      required this.textColor});

  factory AppColorScheme.light() => AppColorScheme(
      primary: const Color(0xFFB22C2D),
      appBarBackground: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      cardSurfaceTintColor: Colors.white,
      cardShadowColor: Colors.grey.shade50.withOpacity(0.25),
      textBtnColor: Colors.white,
      textColor: Colors.black);

  factory AppColorScheme.dark() => AppColorScheme(
      primary: const Color(0xFF1E1E1E),
      appBarBackground: const Color(0xFF1E1E1E),
      scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      cardColor: AppColor.cardDark,
      cardSurfaceTintColor: AppColor.cardDark,
      cardShadowColor: Colors.transparent,
      textBtnColor: Colors.white,
      textColor: Colors.white);
}

class AppColor {
  static const primary = Color(0xFF417afe);
  static const mainColor = Color(0xFFB22C2D);
  static const Color scaffoldDark = Color(0xff222736);
  static const Color drawerBG = Color(0xFFE9F0F9);
  static const Color cardDark = Color(0xff2a3142);
  static const Color backgroundColor = Color(0xffff1e1e1e);
  static const Color grey = Color.fromARGB(255, 160, 157, 157);
  static const Color white = Color(0xFFFFFFFF);
}
