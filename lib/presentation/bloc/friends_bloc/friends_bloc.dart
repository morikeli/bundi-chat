import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/friends.dart';
import '../../../data/models/user.dart';
import '../../../data/repository/friends_repository.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final FriendsRepository _friendsRepo;

  FriendsBloc(this._friendsRepo) : super(FriendsInitial()) {
    on<FollowUserRequested>(_follow);
    on<GetAllUsersRequested>(_retrieveAllUsers);
    on<GetMyFriendsRequested>(_retrieveMyFriends);
  }

  Future<void> _follow(
    FollowUserRequested event,
    Emitter<FriendsState> emit,
  ) async {
    emit(FriendsLoading());
    try {
      await _friendsRepo.follow(event.followedUserId);
      emit(UserFollowed());
    } catch (err) {
      emit(FollowFriendsError(err.toString()));
    }
  }

  Future<void> _retrieveAllUsers(
    GetAllUsersRequested event,
    Emitter<FriendsState> emit,
  ) async {
    emit(FriendsLoading());
    try {
      final friends = await _friendsRepo.findFriends();
      emit(AllUsersLoaded(friends));
    } catch (err) {
      emit(RetrieveAllUsersError(err.toString()));
    }
  }

  Future<void> _retrieveMyFriends(
    GetMyFriendsRequested event,
    Emitter<FriendsState> emit,
  ) async {
    emit(FriendsLoading());

    try {
      final friends = await _friendsRepo.fetchMyFriends(event.currentUserId);
      emit(MyFriendsLoaded(friends));
    } catch (err) {
      emit(RetrieveFriendsError(err.toString()));
    }
  }
}
