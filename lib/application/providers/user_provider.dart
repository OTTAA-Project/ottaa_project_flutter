import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';

class UserNotifier extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? get user => _userModel;

  set user (UserModel? userModel) {
    _userModel = userModel;
  }

  void setUser(UserModel? userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  void clearUser() {
    _userModel = null;
    notifyListeners();
  }
}

final userProvider = ChangeNotifierProvider<UserNotifier>((ref) {
  return UserNotifier();
});
