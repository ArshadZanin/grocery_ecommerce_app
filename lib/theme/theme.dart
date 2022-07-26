import 'package:flutter/material.dart';

const Color gradientPurple = Color.fromRGBO(83, 57, 214, 1);
const Color gradientPink = Color.fromRGBO(153, 38, 171, 1);
const Color gradientBrightMagenta = Color.fromRGBO(255, 2, 97, 1);
const Color gradientBrightPeach = Color.fromRGBO(254, 175, 143, 1);
const Color gradientViolet = Color.fromRGBO(113, 34, 237, 1);
const Color gradientPurpleLight = Color.fromRGBO(154, 80, 211, 1);

class QuizOlympicsTheme {
  static _ThemeColor themeColor = _ThemeColor(
    accentColor: Color(0xFFFCBB6D),
    backgroundColorDark: Colors.white,
    backgroundColorLight: Colors.white,
    primaryColorDark: Color.fromRGBO(92, 80, 222, 1),
    primaryColorLight: Color.fromRGBO(92, 80, 222, 1),
    textColor: Colors.white,
  );
}

class _ThemeColor {
  final Color primaryColorDark;
  final Color primaryColorLight;
  final Color backgroundColorDark;
  final Color backgroundColorLight;
  final Color textColor;
  final Color accentColor;

  const _ThemeColor({
    required this.accentColor,
    required this.backgroundColorDark,
    required this.backgroundColorLight,
    required this.primaryColorDark,
    required this.primaryColorLight,
    required this.textColor,
  });
}
