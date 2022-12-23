import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/locator.dart';
import 'package:ottaa_project_flutter/application/providers/auth_provider.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';

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