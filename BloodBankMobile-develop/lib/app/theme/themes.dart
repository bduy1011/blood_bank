import 'package:flutter/material.dart';

import '../../utils/extension/font_extension.dart';
import 'colors.dart';

class AppThemeData {
  final Brightness brightness;
  final AppColorScheme colorScheme;
  final AppTextTheme textThemeT1;
  final AppTextTheme textThemeT2;
  final AppTextTheme textThemeT3;
  final AppTextTheme textThemeT4;
  final AppTextTheme buttonThemeT1;
  final AppTextTheme buttonThemeT2;
  final AppTextTheme borderThemeT1;
  final AppTextTheme buttonTitleThemeT1;

  const AppThemeData.raw({
    required this.brightness,
    required this.colorScheme,
    required this.textThemeT1,
    required this.textThemeT2,
    required this.textThemeT3,
    required this.buttonThemeT1,
    required this.buttonThemeT2,
    required this.textThemeT4,
    required this.borderThemeT1,
    required this.buttonTitleThemeT1,
  });

  factory AppThemeData({
    required Brightness brightness,
    required AppColorScheme colorScheme,
  }) =>
      AppThemeData.raw(
          brightness: brightness,
          colorScheme: colorScheme,
          textThemeT1: AppTextTheme.create(colorScheme.textColor),
          textThemeT2: AppTextTheme.create(colorScheme.textColor.withOpacity(0.7)),
          textThemeT3: AppTextTheme.create(colorScheme.textColor.withOpacity(0.5)),
          textThemeT4: AppTextTheme.create(colorScheme.textColor.withOpacity(0.2)),
          buttonThemeT1: AppTextTheme.create(colorScheme.textColor),
          buttonThemeT2: AppTextTheme.create(colorScheme.textColor.withOpacity(0.5)),
          borderThemeT1: AppTextTheme.create(
            colorScheme.textColor,
          ),
          buttonTitleThemeT1: AppTextTheme.create(
            colorScheme.textBtnColor,
          ));

  bool get isDark => brightness == Brightness.dark;


  ThemeData get themeData => ThemeData(
      brightness: brightness,
      colorSchemeSeed: colorScheme.primary,
      appBarTheme: AppBarTheme(elevation: 0.0, backgroundColor: colorScheme.appBarBackground),
      scaffoldBackgroundColor: colorScheme.scaffoldBackgroundColor,
      cardTheme: CardThemeData(
          margin: EdgeInsets.zero,
          color: colorScheme.cardColor,
          surfaceTintColor: colorScheme.cardSurfaceTintColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          elevation: 10.0,
          shadowColor: colorScheme.cardShadowColor),
      checkboxTheme: const CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ));

  factory AppThemeData.light() => AppThemeData(brightness: Brightness.light, colorScheme: AppColorScheme.light());

  factory AppThemeData.dark() => AppThemeData(brightness: Brightness.dark, colorScheme: AppColorScheme.dark());
}

class AppTextTheme {
  final TextStyle bigTitle;
  final TextStyle title;
  final TextStyle button;
  final TextStyle textButton;
  final TextStyle header0;
  final TextStyle header1;
  final TextStyle header2;
  final TextStyle body;
  final TextStyle light;
  final TextStyle error;
  final TextStyle superLight;
  final TextStyle placeHolder;

  AppTextTheme({
    required this.bigTitle,
    required this.title,
    required this.button,
    required this.textButton,
    required this.header0,
    required this.header1,
    required this.header2,
    required this.body,
    required this.light,
    required this.error,
    required this.superLight,
    required this.placeHolder,
  });

  factory AppTextTheme.create(Color color) {
    return AppTextTheme(
      bigTitle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color, fontFamily: FontFamily.Nunito.name),
      title: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: color, fontFamily: FontFamily.Nunito.name),
      button: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color, fontFamily: FontFamily.Nunito.name),
      textButton: TextStyle(fontSize: 15, color: color, fontFamily: FontFamily.Nunito.name),
      header0: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: color, fontFamily: FontFamily.Nunito.name),
      header1: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, color: color, fontFamily: FontFamily.Nunito.name),
      header2: TextStyle(fontSize: 16, color: color, fontFamily: FontFamily.Nunito.name),
      body: TextStyle(fontSize: 15, color: color, fontFamily: FontFamily.Nunito.name),
      light: TextStyle(fontSize: 13, color: color, fontFamily: FontFamily.Nunito.name),
      error: TextStyle(fontSize: 17, color: color, fontFamily: FontFamily.Nunito.name),
      superLight: TextStyle(fontSize: 11, color: color, fontFamily: FontFamily.Nunito.name),
      placeHolder: TextStyle(fontSize: 15, color: color, fontFamily: FontFamily.Nunito.name),
    );
  }
}
