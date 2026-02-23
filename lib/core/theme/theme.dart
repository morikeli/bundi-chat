
import 'package:flutter/material.dart';

import 'color.dart';
import 'color_scheme.dart';
import 'theme_data/elevated_btn_theme_data.dart';
import 'theme_data/input_decoration.dart';
import 'theme_data/text_theme_data.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: AppColorScheme.colorSchemeLight,
    dividerColor: kSecondaryColor,
    elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonLightTheme,
    inputDecorationTheme: AppInputDecorationTheme.inputDecorationLightTheme,
    scaffoldBackgroundColor: kScaffoldBgLightColor,
    textTheme: AppTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: AppColorScheme.colorSchemeDark,
    dividerColor: Colors.black,
    elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonDarkTheme,
    inputDecorationTheme: AppInputDecorationTheme.inputDecorationDarkTheme,
    scaffoldBackgroundColor: kScaffoldBgDarkColor,
    textTheme: AppTextTheme.darkTextTheme,
  );
}