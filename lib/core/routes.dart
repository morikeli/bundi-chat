import 'package:flutter/material.dart';

import '../presentation/views/chat/chat_screen.dart';
import '../presentation/views/home/homescreen.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  ChatScreen.routeName: (context) => const ChatScreen(),

};
