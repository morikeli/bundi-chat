import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../core/theme/color.dart';
import '../../../../data/models/threads.dart';
import '../chat_screen.dart';

class InboxMessageTile extends StatelessWidget {
  const InboxMessageTile({
    super.key,
    required this.isRead,
    required this.thread,
  });

  final bool isRead;
  final ChatThread thread;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.pushNamed(context, ChatScreen.routeName, arguments: thread),
      leading: CircleAvatar(backgroundImage: AssetImage(thread.avatar)),
      title: Text(
        thread.userName,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: Row(
          children: [
            Icon(
              isRead ? LineIcons.doubleCheck : LineIcons.doubleCheck,
              color: isRead ? kPrimaryColor : kIconSecondaryColor,
              size: 16.0,
            ),
            SizedBox(width: 4.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * .52,
              child: Text(
                thread.lastMessage.text,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kTextSecondaryColor,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
      trailing: Text(DateFormat('h:mm a').format(thread.lastMessage.timestamp)),
    );
  }
}
