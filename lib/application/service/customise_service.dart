import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/repositories/customise_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

@Singleton(as: CustomiseRepository)
class CustomiseService implements CustomiseRepository {
  final ServerRepository _serverRepository;

  CustomiseService(this._serverRepository);

  @override
  Future<EitherVoid> setShortcutsForUser(
          {required Shortcuts shortcuts, required String userId}) async =>
      await _serverRepository.setShortcutsForUser(
          shortcuts: shortcuts, userId: userId);

  @override
  Future<List<Group>> fetchDefaultGroups({required String languageCode}) async {
    final res = await _serverRepository.getDefaultGroups(languageCode);
    if (res.isRight) {
      final json = res.right;
      final List<Group> groups = json.keys.map<Group>((e) {
        final data = Map.from(json[e] as Map<dynamic, dynamic>);
        return Group.fromMap({
          "id": e,
          ...data,
        });
      }).toList();

      return groups;
    } else {
      return [];
    }
  }

  @override
  Future<List<Picto>> fetchDefaultPictos({required String languageCode}) async {
    final res = await _serverRepository.getDefaultPictos(languageCode);

    if (res.isRight) {
      final json = res.right;
      final List<Picto> pictos = json.keys.map<Picto>((e) {
        final data = Map.from(json[e] as Map<dynamic, dynamic>);
        return Picto.fromMap({
          "id": e,
          ...data,
        });
      }).toList();

      return pictos;
    } else {
      return [];
    }
  }

  @override
  Future<Shortcuts> fetchShortcutsForUser({required String userId}) async {
    final res = await _serverRepository.fetchShortcutsForUser(userId: userId);
    if (res.isRight) {
      return Shortcuts.fromMap(res.right);
    } else {
      return Shortcuts(
        favs: false,
        history: false,
        camera: false,
        share: false,
        games: false,
        no: false,
        yes: false,
      );
    }
  }

  @override
  Future<List<Group>> fetchUserGroups(
      {required String languageCode, required String userId}) async {
    final res = await _serverRepository.fetchUserGroups(
        languageCode: languageCode, userId: userId);
    if (res.isRight) {
      final json = res.right;
      final List<Group> groups = json.keys.map<Group>((e) {
        final data = Map.from(json[e] as Map<dynamic, dynamic>);
        return Group.fromMap({
          "id": e,
          ...data,
        });
      }).toList();

      return groups;
    } else {
      return [];
    }
  }

  @override
  Future<List<Picto>> fetchUserPictos(
      {required String languageCode, required String userId}) async {
    final res = await _serverRepository.fetchUserPictos(
        languageCode: languageCode, userId: userId);

    if (res.isRight) {
      final json = res.right;
      final List<Picto> pictos = json.keys.map<Picto>((e) {
        final data = Map.from(json[e] as Map<dynamic, dynamic>);
        return Picto.fromMap({
          "id": e,
          ...data,
        });
      }).toList();

      return pictos;
    } else {
      return [];
    }
  }
}
