import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/helpers/chat_screen_args.dart';
import '../../../core/utils/app_toast.dart';
import '../../../data/models/chat.dart';
import '../../../data/models/threads.dart';
import '../../../data/models/user.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';
import '../../widgets/common/empty_state_widget.dart';
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
      appBar: ChatScreenAppBar(
        userName: thread.userName,
        userProfilePic: thread.avatar,
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            AppToast.showError(
              context,
              title: "Chats not loaded!",
              message: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          if (state is ChatsLoaded) {
            final chatMessages = state.chats;
            return Column(
              children: [
                ChatsListView(
                  scrollController: _scrollController,
                  receiverId: thread.receiverId,
                  messages: [chatMessages],
                ),
                MessageInputField(receiverId: thread.receiverId),
              ],
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}

class ChatScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatScreenAppBar({super.key, required this.user});

  final UserModel user;

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
            backgroundImage: AssetImage(userProfilePic),
            radius: MediaQuery.of(context).size.width * .04,
          ),
          SizedBox(width: 8.0),
          Text(
            userName,
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
    required this.messages,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<ChatMessage> messages;

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
  MessageInputField({super.key, required this.receiverId});

  final String receiverId;
  final TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: txtController,
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
              onPressed: () async {
                if (txtController.text.trim().isEmpty) return;

                // await repo.sendMessage(receiverId, txtController.text.trim());
                final content = txtController.text.trim();
                context.read<ChatBloc>().add(
                  SendMessageRequested(content, receiverId),
                );
                txtController.clear();
              },
              icon: Icon(CupertinoIcons.paperplane_fill),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
