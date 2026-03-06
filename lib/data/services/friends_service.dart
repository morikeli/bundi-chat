import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user.dart';

class FindFriendsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<UserModel>> getUsers({
    required String currentUserId,
    required int page, // page number starting from 1
    required int pageSize, // number of users per page
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
          .select('''
            id,
            username,
            first_name,
            last_name,
            mobile_number,
            avatar_url,
            created_at
          ''')
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

  Future<List<UserModel>> getFollowedUsers(String currentUserId) async {
    try {
      final response = await _supabase
          .from('friends')
          .select('''
            users!friends_following_id_fkey (
              id,
              username,
              first_name,
              last_name,
              mobile_number,
              avatar_url,
              created_at
            )
          ''')
          .eq('follower_id', currentUserId);
      
      return response.map((e) => UserModel.fromJson(e['users'])).toList();
    } catch (e) {
      throw Exception('Error fetching followed users: $e');
    }
  }
}
