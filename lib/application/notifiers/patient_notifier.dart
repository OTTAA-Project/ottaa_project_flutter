import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';

class PatientNotifier extends StateNotifier<PatientUserModel?> {
  PatientNotifier() : super(null);

  void setUser(PatientUserModel? user) {
    state = user;
  }

  PatientUserModel get user {
    return state!;
  }

  PatientUserModel? get patient {
    return state;
  }
}

final patientNotifier =
    StateNotifierProvider<PatientNotifier, PatientUserModel?>((ref) {
  return PatientNotifier();
});
