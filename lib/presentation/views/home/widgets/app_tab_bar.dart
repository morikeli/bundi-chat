import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../core/theme/color.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    required TabController tabController,
    required this.tabIndex,
  }) : _tabController = tabController;

  final TabController _tabController;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: kTextLightColor,
      dividerColor: Colors.transparent,
      controller: _tabController,
      tabs: [
        Tab(
          icon: Tooltip(
            message: 'Chats',
            waitDuration: Duration(milliseconds: 500),
            child: Icon(
              tabIndex == 0
                  ? CupertinoIcons.chat_bubble_2_fill
                  : LineIcons.comments,
            ),
          ),
        ),
        Tab(
          icon: Tooltip(
            message: 'Friends',
            waitDuration: Duration(milliseconds: 500),
            child: Icon(
              tabIndex == 1
                  ? CupertinoIcons.person_2_fill
                  : LineIcons.userFriends,
            ),
          ),
        ),
        Tab(
          icon: Tooltip(
            message: 'Profile',
            waitDuration: Duration(milliseconds: 500),
            child: Icon(
              tabIndex == 2 ? CupertinoIcons.person_fill : LineIcons.user,
            ),
          ),
        ),
      ],
    );
  }
}
