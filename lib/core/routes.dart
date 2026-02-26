import 'package:flutter/material.dart';

import '../presentation/views/auth/login_screen.dart';
import '../presentation/views/auth/signup_screen.dart';
import '../presentation/views/chat/chat_screen.dart';
import '../presentation/views/home/homescreen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignupScreen.routeName: (context) => const SignupScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ChatScreen.routeName: (context) => const ChatScreen(),

};
