import 'package:flutter_test/flutter_test.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/caregiver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';

void main() {
  final UserModel patient = PatientUserModel(
    id: "0",
    email: "",
    groups: {},
    phrases: {},
    pictos: {},
    settings: PatientSettings.empty(
      UserData(
        avatar: AssetsImage(asset: "", network: "`"),
        birthDate: DateTime.now(),
        genderPref: "",
        lastConnection: DateTime.now(),
        lastName: "",
        name: "",
      ),
    ),
  );

  final UserModel caregiver = CaregiverUserModel(
    id: "0",
    email: "",
    users: {},
    settings: BaseSettingsModel(
      data: UserData(
        avatar: AssetsImage(asset: "", network: "`"),
        birthDate: DateTime.now(),
        genderPref: "",
        lastConnection: DateTime.now(),
        lastName: "",
        name: "",
      ),
      language: LanguageSetting.empty(),
    ),
  );

  final UserModel baseUser = BaseUserModel(
    email: "",
    id: "",
    settings: BaseSettingsModel(
      data: UserData(
        avatar: AssetsImage(asset: "", network: "`"),
        birthDate: DateTime.now(),
        genderPref: "",
        lastConnection: DateTime.now(),
        lastName: "",
        name: "",
      ),
      language: LanguageSetting.empty(),
    ),
  );

  group('User extension tests', () {
    test('isPatient should return true for UserType.user', () {
      expect(patient.isPatient, true);
    });

    test('isPatient should return false for UserType.caregiver', () {
      expect(caregiver.isPatient, false);
    });

    test('isCaregiver should return true for UserType.caregiver', () {
      expect(caregiver.isCaregiver, true);
    });

    test('isNone should return true for UserType.none', () {
      expect(baseUser.isNone, true);
    });

    test('patient should return a PatientUserModel instance', () {
      final patientModel = patient.patient;
      expect(patientModel, isA<PatientUserModel>());
    });

    test('caregiver should return a CaregiverUserModel instance', () {
      final user = caregiver.caregiver;
      expect(user, isA<CaregiverUserModel>());
    });

    test('base should return a BaseUserModel instance', () {
      final base = baseUser.base;
      expect(base, isA<BaseUserModel>());
    });
  });
}
