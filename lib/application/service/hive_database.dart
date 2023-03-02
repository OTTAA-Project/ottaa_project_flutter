import 'package:hive_flutter/hive_flutter.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
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
  @override
  UserModel? user;

  @override
  Future<void> close() async {
    await Hive.close();
  }

  @override
  Future<void> deleteUser() async {
    await Hive.box('user').clear();
    await Hive.box('caregiver').clear();
    await Hive.box('none').clear();
  }

  @override
  Future<UserModel?> getUser() async {
    UserModel? user;

    user ??= Hive.box(UserType.user.name).get(UserType.user.name);

    user ??= Hive.box(UserType.caregiver.name).get(UserType.caregiver.name);

    user ??= Hive.box(UserType.none.name).get(UserType.none.name);

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
    await Hive.initFlutter();

    Hive.registerAdapter(PatientUserModelAdapter());
    Hive.registerAdapter(BaseSettingsModelAdapter());
    Hive.registerAdapter(UserDataAdapter());
    Hive.registerAdapter(AssetsImageAdapter());
    Hive.registerAdapter(PhraseAdapter());
    Hive.registerAdapter(PaymentAdapter());
    Hive.registerAdapter(ShortcutsModelAdapter());
    Hive.registerAdapter(PictoAdapter());
    Hive.registerAdapter(PictoRelationAdapter());
    Hive.registerAdapter(SequenceAdapter());
    // Hive.registerAdapter(TagsAdapter());
    Hive.registerAdapter(GroupAdapter());
    Hive.registerAdapter(GroupRelationAdapter());
    Hive.registerAdapter(CaregiverUserModelAdapter());
    Hive.registerAdapter(PatientSettingsAdapter());
    Hive.registerAdapter(CaregiverUsersAdapter());
    Hive.registerAdapter(BaseUserModelAdapter());
    Hive.registerAdapter(UserTypeAdapter());
    Hive.registerAdapter(DevicesAccessibilityAdapter());
    Hive.registerAdapter(DisplayTypesAdapter());
    Hive.registerAdapter(SizeTypesAdapter());
    Hive.registerAdapter(SweepModesAdapter());
    Hive.registerAdapter(VelocityTypesAdapter());

    Hive.registerAdapter(AccessibilitySettingAdapter());
    Hive.registerAdapter(LanguageSettingAdapter());
    Hive.registerAdapter(LayoutSettingAdapter());
    Hive.registerAdapter(SubtitlesSettingAdapter());
    Hive.registerAdapter(TTSSettingAdapter());

    Hive.registerAdapter(VoiceSettingAdapter());

    await Hive.openBox(UserType.user.name);

    await Hive.openBox(UserType.caregiver.name);

    await Hive.openBox(UserType.none.name);

    await Hive.openBox('intro');

    await getUser();
  }

  @override
  Future<void> setUser(UserModel user) async {
    await Hive.box(user.type.name).put(user.type.name, user);
    user = await Hive.box(user.type.name).get(user.type.name);
    this.user = user;
  }

  @override
  Future<void> setIntro([bool? value]) async {
    await Hive.box('intro').put('first', value ?? true);
  }

  @override
  Future<bool> getIntro() async {
    final res = Hive.box('intro').get('first');
    return res ?? true;
  }
}
