import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../widgets/custom_appbar.dart';
import 'bottom_nav_bar.dart';
import 'widgets/new_message.dart';
import 'widgets/user_avatar.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int tabLength = 3;
  final List<String> appBarTitle = ["Chats", "Find Friends", "Profile"];
  final List<Widget>? fab = [NewMessageFAB()];
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabLength, vsync: this);
    _tabController.addListener(() {
      // The if block prevents unnecessary rebuilds while the
      // tab animation is still in progress.
      if (_tabController.indexIsChanging) return;

      setState(() {
        tabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildFAB() {
    switch (tabIndex) {
      case 0: // Chats
        return NewMessageFAB();

      case 1: // Profile
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * .08,
          ),
          child: FloatingActionButton(
            heroTag: 'profile_fab',
            onPressed: () {},
            child: const Icon(LineIcons.userEdit),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: appBarTitle[tabIndex],
        centerTitle: false,
        actions: [UserAvatar()],
      ),
      body: CustomFloatingBottomNavBar(
        tabController: _tabController,
        tabIndex: tabIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: _buildFAB(),
      ),
    );
  }
}
