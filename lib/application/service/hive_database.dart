import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ottaa_project_flutter/core/enums/devices_accessibility.dart';
import 'package:ottaa_project_flutter/core/enums/display_types.dart';
import 'package:ottaa_project_flutter/core/enums/size_types.dart';
import 'package:ottaa_project_flutter/core/enums/sweep_modes.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/enums/velocity_types.dart';
import 'package:ottaa_project_flutter/core/models/accessibility_setting.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/caregiver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/devices_token.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/layout_setting.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/payment_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/models/subtitles_setting.dart';
import 'package:ottaa_project_flutter/core/models/tts_setting.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/models/voice_setting.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';

@Singleton(as: LocalDatabaseRepository)
class HiveDatabase extends LocalDatabaseRepository {
  late final HiveInterface iHive;

  HiveDatabase({HiveInterface? hive}) {
    iHive = hive ?? Hive;
  }

  @override
  UserModel? user;

  @override
  Future<void> close() async {
    await iHive.close();
  }

  @override
  Future<void> deleteUser() async {
    await iHive.box('user').clear();
    await iHive.box('caregiver').clear();
    await iHive.box('none').clear();
  }

  @override
  Future<UserModel?> getUser() async {
    UserModel? user;

    user ??= iHive.box(UserType.user.name).get(UserType.user.name);

    user ??= iHive.box(UserType.caregiver.name).get(UserType.caregiver.name);

    user ??= iHive.box(UserType.none.name).get(UserType.none.name);

    return this.user ?? user;
  }

  @FactoryMethod(preResolve: true)
  static Future<HiveDatabase> start() async {
    HiveDatabase db = HiveDatabase();
    await db.init();

    return db;
  }

  @override
  Future<void> init() async {
    await iHive.initFlutter();

    iHive.registerAdapter(PatientUserModelAdapter());
    iHive.registerAdapter(BaseSettingsModelAdapter());
    iHive.registerAdapter(UserDataAdapter());
    iHive.registerAdapter(AssetsImageAdapter());
    iHive.registerAdapter(PhraseAdapter());
    iHive.registerAdapter(PaymentAdapter());
    iHive.registerAdapter(ShortcutsModelAdapter());
    iHive.registerAdapter(PictoAdapter());
    iHive.registerAdapter(PictoRelationAdapter());
    iHive.registerAdapter(SequenceAdapter());
    // Hive.registerAdapter(TagsAdapter());
    iHive.registerAdapter(GroupAdapter());
    iHive.registerAdapter(GroupRelationAdapter());
    iHive.registerAdapter(CaregiverUserModelAdapter());
    iHive.registerAdapter(PatientSettingsAdapter());
    iHive.registerAdapter(CaregiverUsersAdapter());
    iHive.registerAdapter(BaseUserModelAdapter());
    iHive.registerAdapter(UserTypeAdapter());
    iHive.registerAdapter(DevicesAccessibilityAdapter());
    iHive.registerAdapter(DisplayTypesAdapter());
    iHive.registerAdapter(SizeTypesAdapter());
    iHive.registerAdapter(SweepModesAdapter());
    iHive.registerAdapter(VelocityTypesAdapter());

    iHive.registerAdapter(AccessibilitySettingAdapter());
    iHive.registerAdapter(LanguageSettingAdapter());
    iHive.registerAdapter(LayoutSettingAdapter());
    iHive.registerAdapter(SubtitlesSettingAdapter());
    iHive.registerAdapter(TTSSettingAdapter());

    iHive.registerAdapter(VoiceSettingAdapter());

    iHive.registerAdapter(DeviceTokenAdapter());

    await iHive.openBox(UserType.user.name);

    await iHive.openBox(UserType.caregiver.name);

    await iHive.openBox(UserType.none.name);

    await iHive.openBox('intro');

    await iHive.openBox('tts');

    await iHive.openBox('longClick');

    await getUser();
  }

  @override
  Future<void> setUser(UserModel user) async {
    Box box = (await secureBox(user.type.name));
    await box.put(user.type.name, user);
    user = box.get(user.type.name);
    this.user = user;
  }

  Future<Box<T>> secureBox<T>(String boxName) async {
    Box<T> box;

    if (iHive.isBoxOpen(boxName)) {
      box = iHive.box(boxName);
    } else {
      box = await iHive.openBox(boxName);
    }

    return box;
  }

  @override
  Future<void> setIntro([bool? value]) async {
    await iHive.box('intro').put('first', value ?? true);
  }

  @override
  Future<bool> getIntro() async {
    final res = iHive.box('intro').get('first');
    return res ?? true;
  }

  @override
  Future<String> getVoice() async {
    final res = iHive.box('tts').get('name');
    return res ?? '';
  }

  @override
  Future<void> setVoice({required String name}) async {
    await iHive.box('tts').put('name', name);
  }

  @override
  Future<void> setLongClick({required bool isLongClick}) async {
    await iHive.box('longClick').put('isLongClick', isLongClick);
  }

  @override
  Future<bool> getLongClick() async {
    final res = iHive.box('longClick').get('isLongClick');
    return res ?? false;
  }

  @override
  ValueListenable getListeneableFromName(String name) {
    return iHive.box(name).listenable();
  }
}
