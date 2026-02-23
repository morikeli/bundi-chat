
import 'package:flutter/material.dart';

import 'color.dart';

class AppColorScheme {
  AppColorScheme._();

  static ColorScheme colorSchemeLight = ColorScheme.light(
    brightness: Brightness.light,
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  );
  
  static ColorScheme colorSchemeDark = ColorScheme.dark(
    brightness: Brightness.dark,
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  );
}
