part of 'friends_bloc.dart';

@immutable
sealed class FriendsEvent {}

final class GetAllUsersRequested extends FriendsEvent {
  // final List<UserModel> users;

  // GetAllUsersRequested(this.users);
}

final class FollowUserRequested extends FriendsEvent {
  final String followedUserId;

  FollowUserRequested(this.followedUserId);
}

final class GetMyFriendsRequested extends FriendsEvent {
  final String currentUserId;

  GetMyFriendsRequested(this.currentUserId);
}