import '../models/friends.dart';
import '../models/user.dart';
import '../services/friends_service.dart';

class FriendsRepository {
  final FindFriendsService _friendsService;

  FriendsRepository(this._friendsService);

  Future<void> follow(String followedUserId) async {
    await _friendsService.follow(followedUserId);
  }

  Future<List<Friends>> fetchMyFriends(String currentUserId) async {
    return await _friendsService.getFollowedUsers(currentUserId);
  }

  Future<List<UserModel>> findFriends(String currentUserId) async {
    return await _friendsService.getUsers(currentUserId: currentUserId, page: 1, pageSize: 20);
  }
}
