import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/app_loading_indicators.dart';
import '../../../data/models/user.dart';
import '../../bloc/friends_bloc/friends_bloc.dart';
import '../../widgets/common/empty_state_widget.dart';

class FindFriendsScreen extends StatelessWidget {
  const FindFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: FindFriendsScreenBody(),
      ),
    );
  }
}

class FindFriendsScreenBody extends StatefulWidget {
  const FindFriendsScreenBody({super.key});

  @override
  State<FindFriendsScreenBody> createState() => _FindFriendsScreenBodyState();
}

class _FindFriendsScreenBodyState extends State<FindFriendsScreenBody> {
  
  @override
  void initState() {
    super.initState();
    context.read<FriendsBloc>().add(GetAllUsersRequested());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendsBloc, FriendsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FriendsLoading) {
          return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
        }

        if (state is AllUsersLoaded) {
          final friends = state.friends;

          if (friends.isEmpty) {
            return EmptyStateWidget(
              icon: LineIcons.userSlash,
              title: "No user found!",
            );
          }

          return FindFriendsListView(friends: friends);
        }

        return SizedBox.shrink();
      },
    );
  }
}

class FindFriendsListView extends StatelessWidget {
  const FindFriendsListView({super.key, required this.friends});

  final List<UserModel> friends;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];

        return ListTile(
          leading: CircleAvatar(
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
            child: ElevatedButton(
              onPressed: () {
                context.read<FriendsBloc>().add(FollowUserRequested(friend.id));
              },
              child: Text('Follow'),
            ),
          ),
        );
      },
    );
  }
}
