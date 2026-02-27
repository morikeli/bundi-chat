import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/auth_repository.dart';
import '../../data/repository/chat_repository.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/chat_service.dart';

/// Provides repositories used across the app.
class AppRepositoryProviders extends StatelessWidget {
  final Widget child;
  const AppRepositoryProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository(AuthService())),
        RepositoryProvider(create: (_) => ChatRepository(ChatService())),

      ],
      child: child,
    );
  }
}
