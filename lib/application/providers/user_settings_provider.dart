import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/enums/devices_accessibility.dart';
import 'package:ottaa_project_flutter/core/enums/display_types.dart';
import 'package:ottaa_project_flutter/core/enums/size_types.dart';
import 'package:ottaa_project_flutter/core/enums/sweep_modes.dart';
import 'package:ottaa_project_flutter/core/enums/velocity_types.dart';
import 'package:ottaa_project_flutter/core/models/accessibility_setting.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/layout_setting.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/models/subtitles_setting.dart';
import 'package:ottaa_project_flutter/core/repositories/user_settings_repository.dart';

class UserSettingsProvider extends ChangeNotifier {
  final I18N _i18n;

  final UserSettingRepository _userSettingRepository;

  UserSettingsProvider(
    this._i18n,
    this._userSettingRepository,
  );

  ///also for the caregiver to change it
  String userId = '';
  bool deleteText = true;
  bool shortcut = true;
  List<bool> selectedShortcuts = [true, true, true, true, true, true, true];
  bool boardView = true;
  bool ottaaLabs = false;
  bool accessibility = true;
  double sliderValue = 1.0;
  int selectedAccessibility = 0;
  bool accessibilityType = true;
  int accessibilitySpeed = 1;
  int voiceType = 0;
  int voiceRate = 0;
  bool mute = false;
  bool show = false;
  int size = 0;
  bool capital = true;
  String language = 'es_AR';
  late AccessibilitySetting accessibilitySetting;
  late LanguageSetting languageSetting;
  late SubtitlesSetting subtitlesSetting;
  late LayoutSetting layoutSetting;

  void notify() {
    notifyListeners();
  }

  Future<void> init() async {
    initialiseSettings();
  }

  Future<void> initialiseSettings() async {
    if (false) {
    } else {
      accessibilitySetting = AccessibilitySetting(
        device: DevicesAccessibility.none,
        sweepMode: SweepModes.elements,
        sweepSpeed: VelocityTypes.mid,
        clickTime: VelocityTypes.mid,
      );
      languageSetting = LanguageSetting(
        language: language,
        labs: false,
      );
      subtitlesSetting = SubtitlesSetting(
        show: false,
        size: SizeTypes.mid,
        caps: true,
      );
      layoutSetting = LayoutSetting(
        display: DisplayTypes.grid,
        cleanup: true,
        shortcuts: ShortcutsModel(
          enable: true,
          favs: true,
          history: true,
          camera: true,
          share: true,
          games: true,
          yes: true,
          no: true,
        ),
      );
    }
  }

  Future<void> changeLanguage({required String languageCode}) async {
    language = languageCode;

    await _i18n.changeLanguage(languageCode);
    notifyListeners();
  }

  Future<void> changeOttaaLabs({required bool value}) async {
    ottaaLabs = value;
    languageSetting.labs = value;
    notifyListeners();
  }

  Future<void> fetchUserSettings({required String userId}) async {}

  Future<void> updateLanguageSettings() async {
    _userSettingRepository.updateLanguageSettings(
      map: languageSetting.toMap(),
      userId: userId,
    );
  }
}

final userSettingsProvider =
    ChangeNotifierProvider<UserSettingsProvider>((ref) {
  final i18N = GetIt.I<I18N>();
  final userSettingsService = GetIt.I<UserSettingRepository>();
  return UserSettingsProvider(i18N, userSettingsService);
});
