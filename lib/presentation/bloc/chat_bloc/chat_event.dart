part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class SendMessageRequested extends ChatEvent {
  final String message, receiverId;

  SendMessageRequested(this.message, this.receiverId);
}

final class InboxMessagesRequested extends ChatEvent {}

final class ChatsRequested extends ChatEvent {}
