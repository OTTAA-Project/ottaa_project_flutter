import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends ChangeNotifier {
  bool isCaregiver = false;
  bool isUser = false;

  bool isLinkAccountOpen = false;

  void notify(){
    notifyListeners();
  }
}

final profileProvider = ChangeNotifierProvider<ProfileNotifier>((ref) {
  return ProfileNotifier();
});