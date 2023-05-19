import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAvatarNotifier extends StateNotifier<int> {
  UserAvatarNotifier() : super(615);

  void changeAvatar(int imageId) {
    state = imageId;
  }

  String getAvatar() {
    return state.toString();
  }
}

final userAvatarNotifier =
    StateNotifierProvider<UserAvatarNotifier, int>((ref) {
  return UserAvatarNotifier();
});
