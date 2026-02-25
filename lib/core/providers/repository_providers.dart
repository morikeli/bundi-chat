import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository.dart';
import '../services/auth_service.dart';

/// Provides repositories used across the app.
class RepositoryProviders extends StatelessWidget {
  final Widget child;
  const RepositoryProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository(AuthService())),
      ],
      child: child,
    );
  }
}
