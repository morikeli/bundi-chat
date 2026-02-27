import 'package:flutter/material.dart';

import '../../chat/inbox_screen.dart';
import '../../find_friends_screen.dart';

class AppTabBarView extends StatelessWidget {
  const AppTabBarView({
    super.key,
    required TabController tabController,
    required this.scrollController,
  }) : _tabController = tabController;

  final TabController _tabController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        // 1. Chat tab
        InboxScreen(scrollController: scrollController),
        // 2. Friends tab
        FindFriendsScreen(),
        // 3. Profile tab
        Center(child: Text('Profile')),
      ],
    );
  }
}
