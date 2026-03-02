import 'package:flutter/material.dart';
import 'widgets/find_friends_body.dart';

class FindFriendsScreen extends StatelessWidget {
  const FindFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: FindFriendsScreenBody(),
      ),
    );
  }
}
