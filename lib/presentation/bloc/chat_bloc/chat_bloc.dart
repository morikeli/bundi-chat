import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/chat.dart';
import '../../../data/models/threads.dart';
import '../../../data/repository/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  List<ChatMessage> _cachedMessages = [];

  ChatBloc(this._chatRepository) : super(ChatInitial()) {
    on<InboxMessagesRequested>(_loadInboxMessages);
    on<ChatsRequested>(_loadChats);
    on<SendMessageRequested>(_sendMessage);
  }

  // StreamSubscription? _inboxSub;

  Future<void> _loadInboxMessages(
    InboxMessagesRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

    await emit.forEach<List<ChatThread>>(
      _chatRepository.streamThreads(),
      onData: (threads) => InboxMessagesLoaded(threads),
      onError: (err, _) => ChatError(err.toString()),
    );

    // await _inboxSub?.cancel();

    // listen to subscription (manually)
    // _inboxSub = _chatRepository.streamThreads().listen(
    //   (threads) {
    //     emit(InboxMessagesLoaded(threads));
    //   },
    //   onError: (err) {
    //     emit(ChatError(err.toString()));
    //   },
    // );
  }

  Future<void> _loadChats(ChatsRequested event, Emitter<ChatState> emit) async {
    try {
      // Emit loading state while preserving previous messages
      if (_cachedMessages.isNotEmpty) {
        emit(ChatsLoading(_cachedMessages));
      } else {
        emit(ChatLoading());
      }

      await emit.forEach<List<ChatMessage>>(
        _chatRepository.streamMessages(event.receiverId),
        onData: (messages) {
          _cachedMessages = messages;
          return ChatsLoaded(messages);
        },
        onError: (err, _) => ChatError(err.toString()),
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _sendMessage(
    SendMessageRequested event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _chatRepository.sendMessage(event.receiverId, event.message);

      // Don't emit any state here - let the stream from _loadChats handle it
      // The message stream should automatically emit ChatsLoaded with the new message
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
