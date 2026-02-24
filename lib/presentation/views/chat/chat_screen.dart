import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/chat.dart';
import 'widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat-screen';
  final ChatThread? thread;
  const ChatScreen({super.key, this.thread});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final thread = ModalRoute.of(context)!.settings.arguments as ChatThread;
    return Scaffold(
      appBar: ChatScreenAppBar(),
      body: Column(
        children: [
          ChatsListView(scrollController: _scrollController),
          MessageInputField(),
        ],
      ),
    );
  }
}

class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatScreenAppBar({
    super.key,
  });


  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(CupertinoIcons.back),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/imgs/dps/1.jpg'),
            radius: MediaQuery.of(context).size.width * .04,
          ),
          SizedBox(width: 8.0),
          Text(
            'Test User',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}

class ChatsListView extends StatelessWidget {
  const ChatsListView({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        cacheExtent: 500.0,
        reverse: true,
        itemBuilder: (context, index) {
          // access messages in reverse order using the reversed property of the list
          final message = messages.reversed.elementAt(index);
          return ChatBubble(message: message);
        },
      ),
    );
  }
}

class MessageInputField extends StatelessWidget {
  const MessageInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Message ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide.none,
                ),
                // filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.paperplane_fill),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
