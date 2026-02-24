import 'package:flutter/material.dart';

import '../../../data/models/threads.dart';
import 'widgets/inbox_msg_tile.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      radius: Radius.circular(10.0),
      controller: scrollController,
      child: ListView.builder(
        controller: scrollController,
        cacheExtent: 200.0,
        padding: EdgeInsets.only(bottom: 88.0),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final thread = threads[index];
          return InboxMessageTile(
            isRead: thread.lastMessage.isRead,
            thread: thread,
          );
        },
        itemCount: threads.length,
      ),
    );
  }
}
