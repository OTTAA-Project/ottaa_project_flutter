import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class CustomiseRepository {
  Future<EitherVoid> setShortcutsForUser({required Shortcuts shortcuts, required String userId});

  Future<List<Group>> fetchDefaultGroups({required String languageCode});
}
