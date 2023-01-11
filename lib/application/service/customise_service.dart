import 'dart:convert';

import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/repositories/customise_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class CustomiseService implements CustomiseRepository {
  final ServerRepository _serverRepository;

  CustomiseService(this._serverRepository);

  @override
  Future<EitherVoid> setShortcutsForUser({required Shortcuts shortcuts, required String userId}) async => await _serverRepository.setShortcutsForUser(shortcuts: shortcuts, userId: userId);

  @override
  Future<List<Group>> fetchDefaultGroups({required String languageCode}) async {
    final res = await _serverRepository.getDefaultGroups(languageCode);
    // final List<dynamic> json = jsonDecode(res.right);
    final re = jsonEncode(res.right);
    final json = jsonDecode(re);
    final List<Group> groups = json.map((e) => Group.fromJson(e)).toList();

    return groups;
  }
}
