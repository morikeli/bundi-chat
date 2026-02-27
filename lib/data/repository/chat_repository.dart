import '../../core/services/chat_service.dart';
import '../models/chat.dart';
import '../models/threads.dart';

class ChatRepository {
  final ChatService _service;

  ChatRepository(this._service);

  Stream<List<ChatMessage>> streamMessages(String userId) {
    return _service.streamMessages(userId);
  }

  Stream<List<ChatThread>> streamThreads() {
    return _service.streamThreads();
  }

  Future<void> sendMessage(String receiverId, String content) {
    return _service.sendMessage(
      receiverId: receiverId,
      content: content,
    );
  }
}