import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';

part './app_theme_data.dart';
part './app_colors.dart';

class AppTheme {
  static AppTheme instance = AppTheme._();

  AppTheme._();

  final AppThemeData themeData = AppThemeData();

  ThemeData? defaultThemeData() {
    return themeData.buildTheme();
  }
}
