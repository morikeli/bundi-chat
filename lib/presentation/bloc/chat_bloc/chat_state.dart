part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSent extends ChatState {}

final class InboxMessagesLoaded extends ChatState {
  final List<ChatThread> inboxMessages;

  InboxMessagesLoaded(this.inboxMessages);
}

final class ChatsLoaded extends ChatState {
  final ChatMessage chats;

  ChatsLoaded(this.chats);
}

final class ChatError extends ChatState {
  final String errorMessage;

  ChatError(this.errorMessage);
}