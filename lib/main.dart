import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import 'core/routes.dart';
import 'core/theme/theme.dart';
import 'presentation/views/home/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProviders(
      child: AppBlocProviders(
        child: AdaptiveTheme(
          light: AppTheme.lightTheme,
          dark: AppTheme.darkTheme,
          initial: AdaptiveThemeMode.system,
          builder: (theme, darkTheme) => MaterialApp(
            darkTheme: darkTheme,
            theme: theme,
            debugShowCheckedModeBanner: false,
            title: 'tuChat',
            routes: routes,
            builder: (context, child) =>
                ToastificationWrapper(child: child ?? const SizedBox.shrink()),
            home: HomeScreen(),
          ),
        ),
      ),
    );
  }
}