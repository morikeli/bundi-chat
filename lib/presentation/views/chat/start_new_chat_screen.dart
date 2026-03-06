import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/helpers/chat_screen_args.dart';
import '../../../core/utils/app_loading_indicators.dart';
import '../../../core/utils/app_toast.dart';
import '../../../data/models/user.dart';
import '../../bloc/friends_bloc/friends_bloc.dart';
import '../../widgets/common/empty_state_widget.dart';
import '../../widgets/custom_appbar.dart';
import 'chat_screen.dart';

class StartNewChatScreen extends StatelessWidget {
  const StartNewChatScreen({super.key});
  static const String routeName = '/new-chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarTitle: 'Select follower',
        goBackToPreviousScreen: true,
      ),
      body: StartNewChatBodyWidget(),
    );
  }
}

class StartNewChatBodyWidget extends StatefulWidget {
  const StartNewChatBodyWidget({super.key});

  @override
  State<StartNewChatBodyWidget> createState() => _StartNewChatBodyWidgetState();
}

class _StartNewChatBodyWidgetState extends State<StartNewChatBodyWidget> {
  final String currentUserId = Supabase.instance.client.auth.currentUser!.id;

  List<UserModel> _myCachedFriends = [];

  @override
  void initState() {
    super.initState();
    context.read<FriendsBloc>().add(GetMyFriendsRequested(currentUserId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendsBloc, FriendsState>(
      listener: (context, state) {
        if (state is MyFriendsLoaded) {
          _myCachedFriends = state.friends;
        } else if (state is RetrieveFriendsError) {
          AppToast.showError(
            context,
            title: "Can't load followers",
            message: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        if (state is FriendsLoading) {
          return Center(child: AppLoadingIndicators.loadingIndicatorLarge());
        }

        if (state is MyFriendsLoaded) {
          if (_myCachedFriends.isEmpty) {
            return EmptyStateWidget(
              icon: LineIcons.userTag,
              title: "No followers found!",
              subtitle: "It's time to gain some followers",
            );
          }
        }

        final friends = _myCachedFriends;

        return ListView.builder(
          itemCount: friends.length,
          itemBuilder: (context, index) {
            final friend = friends[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/imgs/dps/1.jpg'),
              ),
              title: Text('${friend.firstName} ${friend.lastName}'),
              subtitle: Text(
                friend.username,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: SizedBox(
                height: 28.0,
                width: MediaQuery.of(context).size.width * 0.25,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    ChatScreen.routeName,
                    arguments: ChatScreenArgs(user: friend),
                  ),
                  child: Icon(LineIcons.commentDots),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
