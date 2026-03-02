import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/friends.dart';
import '../models/user.dart';

class FindFriendsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserModel>> getUsers({
  required String currentUserId,
  required int page,  // page number starting from 1
  required int pageSize,  // number of users per page
  }) async {
    final from = (page - 1) * pageSize;
    final to = from + pageSize - 1;

    try {
    // 1. Get IDs of users I already follow
    final followed = await _supabase
        .from('friends')
        .select('following_id')
        .eq('follower_id', currentUserId);

    final followedIds = followed
        .map((e) => e['following_id'] as String)
        .toList();

    // 2. Build exclusion list
    final excludeIds = {currentUserId, ...followedIds}.toList();

    // 3. Query users excluding them
    final users = await _supabase
          .from('users')
          .select('id, username, first_name, last_name, created_at')
        .not('id', 'in', excludeIds)
        .order('username')
        .range(from, to);

    return users.map(UserModel.fromJson).toList();
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }

  Future<void> follow(String followedUserId) async {
    final currentUser = _supabase.auth.currentUser!.id;
    await _supabase.from('friends').insert({
      'follower_id': currentUser,
      'following_id': followedUserId,
    });
  }

  Future<List<Friends>> getFollowedUsers(String currentUserId) async {
    try {
      final List<Map<String, dynamic>> response = await _supabase
          .from('friends')
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
