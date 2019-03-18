import 'package:flutter/material.dart';

/// 全局配置
class GlobalConfig {

  static var dark = false;

  static ThemeData themeDataDark = ThemeData.dark();

  static ThemeData themeDataLight = ThemeData(
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  static getThemeData(bool dark) {
    return dark ? themeDataDark :themeDataLight;
  }

  static ThemeData themeData = getThemeData(dark);
}