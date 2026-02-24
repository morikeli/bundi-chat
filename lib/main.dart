import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'core/theme/theme.dart';
import 'presentation/views/home/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'tuChat',
        darkTheme: darkTheme,
        theme: theme,
        home: HomeScreen(),
        
      ),
    );
  }
}