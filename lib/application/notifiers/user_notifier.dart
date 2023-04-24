import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';

class UserStateNotifier extends StateNotifier<UserModel?> {
  final UserNotifier userState;

  UserStateNotifier(this.userState) : super(userState.user);

  void setUser(UserModel? user) {
    userState.user = user;
  }

  UserModel get user {
    return userState.user!;
  }
}

final userNotifier = StateNotifierProvider<UserStateNotifier, UserModel?>((ref) {
  final userState = ref.watch(userProvider);
  return UserStateNotifier(userState);
});
