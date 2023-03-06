import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void setUser(UserModel? user) {
    state = user;
  }

  UserModel get user {
    return state!;
  }

}

final userNotifier = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});