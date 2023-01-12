import 'package:ottaa_project_flutter/core/models/groups_model.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class CustomiseRepository {
  Future<EitherVoid> setShortcutsForUser(
      {required Map<String, dynamic> shortcuts, required String userId});

  Future<List<Groups>> fetchDefaultGroups({required String languageCode});
}
