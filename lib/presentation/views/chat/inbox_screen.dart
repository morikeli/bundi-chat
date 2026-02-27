import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../../../core/utils/app_loading_indicators.dart';
import '../../../core/utils/app_toast.dart';
import '../../bloc/chat_bloc/chat_bloc.dart';
import '../../widgets/common/empty_state_widget.dart';
import 'widgets/inbox_msg_tile.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(InboxMessagesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      radius: Radius.circular(10.0),
      controller: widget.scrollController,
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            AppToast.showError(
              context,
              title: 'Error!',
              message: state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          if (state is ChatLoading) {
            return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
          }

          if (state is InboxMessagesLoaded) {
            final threads = state.inboxMessages;
            if (threads.isEmpty) {
              return EmptyStateWidget(
                icon: LineIcons.comments,
                title: "You don't have any chats",
                subtitle: "Your chats will appear here",
              );
            }

            return ListView.builder(
              controller: widget.scrollController,
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
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
