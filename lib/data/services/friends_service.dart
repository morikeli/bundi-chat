import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/friends.dart';
import '../models/user.dart';

class FindFriendsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserModel>> getUsers({
    required int page, // page number, starting at 1
    required int pageSize, // number of users per page
  }) async {
    final from = (page - 1) * pageSize;
    final to = from + pageSize - 1;

    try {
      final List<Map<String, dynamic>> users = await _supabase
          .from('users')
          .select('id, username, first_name, last_name, created_at')
          .order('username', ascending: true)
          .range(from, to); // pagination range

      print('users: $users');
      return users
          .map(
            (json) => UserModel(
              id: json["id"] as String,
              username: json["username"] as String,
              createdAt: DateTime.parse(json["created_at"] as String),
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  Future<void> follow(String followedUserId) async {
    final currentUser = _supabase.auth.currentUser!.id;
    await _supabase.from('follows').insert({
      'follower_id': currentUser,
      'following_id': followedUserId,
    });
  }

  Future<List<Friends>> getFollowedUsers(String currentUserId) async {
    try {
      final List<Map<String, dynamic>> response = await _supabase
          .from('follows')
          .select()
          .eq('follower_id', currentUserId);

      // Map Supabase rows to Friends objects
      return response
          .map(
            (json) => Friends(
              id: json['id'] as String,
              followerId: json['follower_id'] as String,
              followingId: json['following_id'] as String,
              createdAt: DateTime.parse(json['created_at'] as String),
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Error fetching followed users: $e');
    }
  }
}
