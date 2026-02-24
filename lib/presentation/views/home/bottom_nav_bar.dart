import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';

import '../../../core/theme/color.dart';
import 'widgets/home_tab_bar.dart';
import 'widgets/home_tab_bar_view.dart';

class CustomFloatingBottomNavBar extends StatelessWidget {
  const CustomFloatingBottomNavBar({
    super.key,
    required TabController tabController,
    required this.tabIndex,
  }) : _tabController = tabController;

  final TabController _tabController;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      borderRadius: BorderRadius.circular(20.0),
      barColor: kPrimaryColor,
      showIcon: false,
      fit: StackFit.expand,
      child: HomeTabBar(tabController: _tabController, tabIndex: tabIndex),
      body: (context, scrollController) => HomeTabBarView(
        tabController: _tabController,
        scrollController: scrollController,
      ),
    );
  }
}
