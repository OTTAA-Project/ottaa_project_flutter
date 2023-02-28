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
import 'package:ottaa_project_flutter/core/models/tts_setting.dart';
import 'package:ottaa_project_flutter/core/models/voice_setting.dart';
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
  late SubtitlesSetting subtitlesSetting;
  late LayoutSetting layoutSetting;
  late VoiceSetting voiceSetting;
  late TTSSetting ttsSetting;

  void notify() {
    notifyListeners();
  }

  Future<void> init() async {
    language = _i18n.currentLanguage!.locale.toString();
    initialiseSettings();
  }

  Future<void> initialiseSettings() async {
    // final rs = {};
    // AccessibilitySetting.fromMap(rs['accesiblity']);
    if (false) {
    } else {
      accessibilitySetting = AccessibilitySetting.empty();
      languageSetting = LanguageSetting.empty();
      subtitlesSetting = SubtitlesSetting.empty();
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
      voiceSetting = VoiceSetting.empty();
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

  Future<void> fetchUserSettings({required String userId}) async {}

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
          "name": voiceSetting.voicesNames,
          "speed": voiceSetting.voicesSpeed
              .map((key, value) => MapEntry(key, value.name)),
          "mutePict": voiceSetting.mutePict
        },
        "subtitles": {
          "show": subtitlesSetting.show,
          "size": subtitlesSetting.size.name,
          "caps": subtitlesSetting.caps
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

  void changeVoiceType({required String type}) {
    voiceType = type;
    voiceSetting.voicesNames[language] = type;
    notifyListeners();
  }

  void changeVoiceSpeed({required VelocityTypes type}) {
    voiceRate = type.name;
    print(type);
    voiceSetting.voicesSpeed[language] = type;
    notifyListeners();
  }

  void changeMute({required bool value}) {
    voiceSetting.mutePict = value;
    mute = value;
    notifyListeners();
  }

  void changeSubtitle({required bool value}) {
    subtitlesSetting.show = value;
    show = value;
    notifyListeners();
  }

  void changeTextType({required SizeTypes type}) {
    size = type;
    subtitlesSetting.size = type;
    notifyListeners();
  }

  void changeCapital({required bool value}) {
    capital = value;
    subtitlesSetting.caps = value;
    notifyListeners();
  }

  void changeSpeed({required double value}) {
    ///
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
}

final userSettingsProvider =
    ChangeNotifierProvider<UserSettingsProvider>((ref) {
  final i18N = GetIt.I<I18N>();
  final userSettingsService = GetIt.I<UserSettingRepository>();
  return UserSettingsProvider(i18N, userSettingsService);
});
