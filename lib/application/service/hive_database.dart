import 'package:hive_flutter/hive_flutter.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/caregiver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/payment_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';

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

  @override
  Future<bool> getIntro()async{
    final res = Hive.box('intro').get('first');
    return res ?? false;
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
    Hive.registerAdapter(ShortcutsAdapter());
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
  Future<void> setIntro() async {
    await Hive.box('intro').put('first', true);
  }
}
