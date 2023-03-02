import 'dart:convert';

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
import 'package:ottaa_project_flutter/core/models/tts_setting.dart';
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
  DisplayTypes boardView = DisplayTypes.grid;
  bool ottaaLabs = false;
  bool accessibility = true;
  double sliderValue = 1.0;
  DevicesAccessibility selectedAccessibility = DevicesAccessibility.press;
  SweepModes selectionType = SweepModes.elements;
  VelocityTypes accessibilitySpeed = VelocityTypes.mid;
  String voiceType = 'default1';
  String voiceRate = VelocityTypes.mid.name;
  bool mute = false;
  bool show = false;
  SizeTypes size = SizeTypes.small;
  bool capital = true;
  String language = 'es_AR';
  late AccessibilitySetting accessibilitySetting;
  late LanguageSetting languageSetting;
  late LayoutSetting layoutSetting;
  late TTSSetting ttsSetting;

  void notify() {
    notifyListeners();
  }

  Future<dynamic> fetchUserSettings() async {
    return await _userSettingRepository.fetchUserSettings(userId: userId);
  }

  Future<void> init() async {
    language = _i18n.currentLanguage!.locale.toString();
    await initialiseSettings();
  }

  Future<void> initialiseSettings() async {
    final res = await fetchUserSettings();
    if (res.isRight) {
      final data = res.right;
      accessibilitySetting = AccessibilitySetting.fromMap(
          jsonDecode(jsonEncode(data['accessibility']))
              as Map<String, dynamic>);
      languageSetting = LanguageSetting.fromMap(
          jsonDecode(jsonEncode(data['language'])) as Map<String, dynamic>);
      ttsSetting = TTSSetting.fromMap(
          jsonDecode(jsonEncode(data['tts'])) as Map<String, dynamic>);
      layoutSetting = LayoutSetting.fromMap(
          jsonDecode(jsonEncode(data['layout'])) as Map<String, dynamic>);
    } else {
      accessibilitySetting = AccessibilitySetting.empty();
      languageSetting = LanguageSetting.empty();
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
      ttsSetting = TTSSetting.empty();
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

  Future<void> updateLanguageSettings() async {
    _userSettingRepository.updateLanguageSettings(
      map: languageSetting.toMap(),
      userId: userId,
    );
  }

  Future<void> updateVoiceAndSubtitleSettings() async {
    _userSettingRepository.updateVoiceAndSubtitleSettings(
      map: {
        "voice": {
          "name": ttsSetting.voiceSetting.voicesNames,
          "speed": ttsSetting.voiceSetting.voicesSpeed
              .map((key, value) => MapEntry(key, value.name)),
          "mutePict": ttsSetting.voiceSetting.mutePict
        },
        "subtitles": {
          "show": ttsSetting.subtitlesSetting.show,
          "size": ttsSetting.subtitlesSetting.size.name,
          "caps": ttsSetting.subtitlesSetting.caps
        }
      },
      userId: userId,
    );
  }

  Future<void> updateAccessibilitySettings() async {
    print(accessibilitySetting.toMap());
    _userSettingRepository.updateAccessibilitySettings(
      map: accessibilitySetting.toMap(),
      userId: userId,
    );
  }

  Future<void> updateMainSettings() async {
    print(layoutSetting.toMap());
    _userSettingRepository.updateMainSettings(
      map: layoutSetting.toMap(),
      userId: userId,
    );
  }

  void changeVoiceType({required String type}) {
    voiceType = type;
    ttsSetting.voiceSetting.voicesNames[language] = type;
    notifyListeners();
  }

  void changeVoiceSpeed({required VelocityTypes type}) {
    voiceRate = type.name;
    print(type);
    ttsSetting.voiceSetting.voicesSpeed[language] = type;
    notifyListeners();
  }

  void changeMute({required bool value}) {
    ttsSetting.voiceSetting.mutePict = value;
    mute = value;
    notifyListeners();
  }

  void changeSubtitle({required bool value}) {
    ttsSetting.subtitlesSetting.show = value;
    show = value;
    notifyListeners();
  }

  void changeTextType({required SizeTypes type}) {
    size = type;
    ttsSetting.subtitlesSetting.size = type;
    notifyListeners();
  }

  void changeCapital({required bool value}) {
    capital = value;
    ttsSetting.subtitlesSetting.caps = value;
    notifyListeners();
  }

  void changeSpeed({required double value}) {
    ///change it after doing some other work
    if (value >= 3.0) {}
    accessibilitySetting.clickTime = VelocityTypes.mid;
    sliderValue = value;
    notifyListeners();
  }

  void changeDeviceOnOff({required bool mode}) {
    if (mode) {
      accessibilitySetting.device = DevicesAccessibility.press;
    } else {
      accessibilitySetting.device = DevicesAccessibility.none;
    }
    notifyListeners();
  }

  void changeDevice({required DevicesAccessibility devicesAccessibility}) {
    accessibilitySetting.device = devicesAccessibility;
    selectedAccessibility = devicesAccessibility;
    notifyListeners();
  }

  void changeSelection({required SweepModes modes}) {
    accessibilitySetting.sweepMode = modes;
    selectionType = modes;
    notifyListeners();
  }

  void changeAccessibilitySpeed({required VelocityTypes speed}) {
    accessibilitySetting.sweepSpeed = speed;
    accessibilitySpeed = speed;
    notifyListeners();
  }

  void changeDeleteText({required bool value}) {
    layoutSetting.cleanup = value;
    deleteText = value;
    notifyListeners();
  }

  changeEnableShortcuts({required bool value}) {
    layoutSetting.shortcuts.enable = value;
    shortcut = value;
    notifyListeners();
  }

  void changeTablet({required DisplayTypes value}) {
    layoutSetting.display = value;
    boardView = value;
    notifyListeners();
  }
}

final userSettingsProvider =
    ChangeNotifierProvider<UserSettingsProvider>((ref) {
  final i18N = GetIt.I<I18N>();
  final userSettingsService = GetIt.I<UserSettingRepository>();
  return UserSettingsProvider(i18N, userSettingsService);
});
