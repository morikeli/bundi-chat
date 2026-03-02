part of 'friends_bloc.dart';

@immutable
sealed class FriendsState {}

final class FriendsInitial extends FriendsState {}

final class FriendsLoading extends FriendsState {}

final class UserFollowed extends FriendsState {}

final class AllUsersLoaded extends FriendsState {
  final List<UserModel> friends;

  AllUsersLoaded(this.friends);
}

final class MyFriendsLoaded extends FriendsState {
  final List<Friends> friends;

  MyFriendsLoaded(this.friends);
}

final class RetrieveAllUsersError extends FriendsState {
  final String errorMessage;

  RetrieveAllUsersError(this.errorMessage);
}

final class RetrieveFriendsError extends FriendsState {
  final String errorMessage;

  RetrieveFriendsError(this.errorMessage);
}

final class FollowFriendsError extends FriendsState {
  final String errorMessage;

  FollowFriendsError(this.errorMessage);
}