import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository.dart';
import '../../presentation/bloc/auth_bloc/auth_bloc.dart';

/// Provides Blocs used across the app.
class AppBlocProviders extends StatelessWidget {
  final Widget child;
  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(context.read<AuthRepository>()),
        ),
      ],
      child: child,
    );
  }
}
