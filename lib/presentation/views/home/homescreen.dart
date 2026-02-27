import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: 'Chats',
        centerTitle: false,
        actions: [UserAvatar()],
      ),
      body: CustomFloatingBottomNavBar(
        tabController: _tabController,
        tabIndex: tabIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: NewMessageFAB(),
    );
  }
}
