import '../../data/models/threads.dart';
import '../../data/models/user.dart';

class ChatScreenArgs {
  final ChatThread? thread;
  final UserModel? user;

  ChatScreenArgs({this.thread, this.user});
}