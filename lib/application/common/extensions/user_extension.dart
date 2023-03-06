import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/caregiver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';

extension User on UserModel {
  PatientUserModel get patient {
    return this as PatientUserModel;
  }

  bool get isPatient {
    return type == UserType.user;
  }

  bool get isCaregiver {
    return type == UserType.caregiver;
  }

  bool get isNone {
    return type == UserType.none;
  }

  CaregiverUserModel get caregiver {
    return this as CaregiverUserModel;
  }

  BaseUserModel get base {
    return this as BaseUserModel;
  }

}