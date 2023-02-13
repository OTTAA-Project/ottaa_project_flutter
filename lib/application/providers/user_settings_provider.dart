import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';

class UserSettingsProvider extends ChangeNotifier {
  final I18N _i18n;
  ///also for the caregiver to change it
  String userId='';

  UserSettingsProvider(
    this._i18n,
  );
}

final userSettingsProvider =
    ChangeNotifierProvider<UserSettingsProvider>((ref) {
  final i18N = GetIt.I<I18N>();
  return UserSettingsProvider(i18N);
});
