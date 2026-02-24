import 'package:flutter/material.dart';

import '../../chat/inbox_screen.dart';

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
    final bool isRead = true;

    return TabBarView(
      controller: _tabController,
      children: [
        // 1. Chat tab
        InboxScreen(scrollController: scrollController, isRead: isRead),
        // 2. Friends tab
        Center(child: Text('Friends')),
        // 3. Profile tab
        Center(child: Text('Profile')),
      ],
    );
  }
}
