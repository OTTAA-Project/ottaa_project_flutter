import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';

class UserSettingsProvider extends ChangeNotifier {
  final I18N _i18n;

  ///also for the caregiver to change it
  String userId = '';
  bool deleteText = true;
  bool shortcut = true;
  List<bool> selectedShortcuts = [true, true, true, true, true, true, true];
  bool boardView = true;
  bool ottaaLabs = true;
  bool accessibility = true;
  double sliderValue = 1.0;
  int selectedAccessibility = 0;
  bool accessibilityType = true;
  int accessibilitySpeed = 1;

  UserSettingsProvider(
    this._i18n,
  );

  void notify() {
    notifyListeners();
  }
}

final userSettingsProvider =
    ChangeNotifierProvider<UserSettingsProvider>((ref) {
  final i18N = GetIt.I<I18N>();
  return UserSettingsProvider(i18N);
});
