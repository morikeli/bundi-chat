import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/app_loading_indicators.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../data/models/user.dart';
import '../../../bloc/friends_bloc/friends_bloc.dart';
import '../../../widgets/common/empty_state_widget.dart';

class FindFriendsScreenBody extends StatefulWidget {
  const FindFriendsScreenBody({super.key});

  @override
  State<FindFriendsScreenBody> createState() => _FindFriendsScreenBodyState();
}

class _FindFriendsScreenBodyState extends State<FindFriendsScreenBody> {
  final String currentUserId = Supabase.instance.client.auth.currentUser!.id;
  List<UserModel> _cachedFriends = [];
  String? _loadingFriendId;

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  void _refreshUsers() {
    context.read<FriendsBloc>().add(GetAllUsersRequested(currentUserId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendsBloc, FriendsState>(
      listener: (context, state) {
        if (state is RetrieveAllUsersError) {
          AppToast.showError(
            context,
            title: 'Cannot fetch users!',
            message: state.errorMessage.toString(),
          );
        } else if (state is FollowFriendsError) {
          _loadingFriendId = null;
          AppToast.showError(
            context,
            title: 'Cannot follow user!',
            message: state.errorMessage.toString(),
          );
        } else if (state is UserFollowed) {
          _loadingFriendId = null;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User followed successfully!')),
          );
          // optionally re-fetch to update the list/company
          _refreshUsers();
        } else if (state is AllUsersLoaded) {
          _cachedFriends = state.friends;
        }
      },
      builder: (context, state) {
        if (state is AllUsersLoaded) {
          final friends = state.friends;

          if (friends.isEmpty) {
            return EmptyStateWidget(
              icon: LineIcons.userSlash,
              title: "No user found!",
              subtitle: "Users you can follow will appear here",
            );
          }
        }

        return FindFriendsListView(
          friends: _cachedFriends,
          loadingFriendId: _loadingFriendId,
          onFollow: (id) {
            setState(() => _loadingFriendId = id);
            context.read<FriendsBloc>().add(FollowUserRequested(id));
          },
        );
      },
    );
  }
}

class FindFriendsListView extends StatelessWidget {
  const FindFriendsListView({
    super.key,
    required this.friends,
    this.loadingFriendId,
    this.onFollow,
  });

  final List<UserModel> friends;
  final String? loadingFriendId;
  final void Function(String friendId)? onFollow;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        final isLoading = loadingFriendId == friend.id;

        return ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/imgs/dps/1.jpg'),
            radius: 20.0,
          ),
          title: Text('${friend.firstName} ${friend.lastName}'),
          subtitle: Text(
            '@${friend.username}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: SizedBox(
            height: 28.0,
            width: MediaQuery.of(context).size.width * 0.25,
            child: ElevatedButton(
              onPressed: isLoading ? null : () => onFollow?.call(friend.id),
              child: isLoading
                  ? Center(child: AppLoadingIndicators.loadingIndicatorExtraSmall())
                  : const Text('Follow'),
            ),
          ),
        );
      },
    );
  }
}
