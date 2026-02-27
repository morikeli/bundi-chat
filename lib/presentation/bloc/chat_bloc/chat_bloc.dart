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
      emit(ChatLoading());
      _chatRepository.streamThreads();
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _sendMessage(
    SendMessageRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      await _chatRepository.sendMessage(event.receiverId, event.message);
      emit(ChatSent());
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
