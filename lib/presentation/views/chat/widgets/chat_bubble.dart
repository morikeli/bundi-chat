import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../core/theme/color.dart';
import '../../../../data/models/chat.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Bubble(
      alignment: message.isSentByMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      color: message.isSentByMe ? Colors.blue.shade900 : Colors.grey.shade600,
      elevation: 4.0,
      margin: BubbleEdges.symmetric(vertical: 10.0),
      nip: message.isSentByMe ? BubbleNip.rightTop : BubbleNip.leftTop,
      child: Column(
        crossAxisAlignment: .end,
        children: [
          Text(
            message.text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: kTextLightColor,
              fontSize: 14.0,
            ),
          ),
          Row(
            mainAxisAlignment: .end,
            mainAxisSize: .min,
            children: [
              Text(
                DateFormat('hh:mm a').format(message.timestamp),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: message.isSentByMe
                      ? kTextSecondaryColor
                      : kTextLightColor,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(width: 8.0),

              // show delivery status only for sent messages
              if (message.isSentByMe)
                Icon(LineIcons.doubleCheck, color: kPrimaryColor, size: 14.0),
            ],
          ),
        ],
      ),
    );
  }
}
