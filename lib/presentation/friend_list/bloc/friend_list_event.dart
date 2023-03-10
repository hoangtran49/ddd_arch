import 'package:ddd_arch/app/base/bloc/base_bloc_event.dart';
import 'package:ddd_arch/domain/models/friend/friend.dart';

class FriendListEvent extends BaseBlocEvent {}

class RequestSubcribeEvent extends FriendListEvent {}

class AddFriendEvent extends FriendListEvent {}

class InitLoadFriendEvent extends FriendListEvent {}

class ClearFriendEvent extends FriendListEvent {}

class DeleteFriendEvent extends FriendListEvent {
  DeleteFriendEvent(this.friend);

  final Friend friend;
}

class UndoDeleteFriend extends FriendListEvent {
  UndoDeleteFriend(this.friend);

  final Friend friend;
}
