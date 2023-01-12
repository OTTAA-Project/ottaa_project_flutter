import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class GroupsService extends GroupsRepository {
  final AuthRepository _authService;
  final RemoteStorageRepository _remoteStorageService;
  final ServerRepository _serverRepository;

  GroupsService(this._authService, this._remoteStorageService, this._serverRepository);

  @override
  Future<List<Group>> getAllGroups({bool defaultGroups = false}) async {
    await Future.delayed(
      const Duration(seconds: kIsWeb ? 2 : 1),
    );

    final result = await _authService.getCurrentUser();
    if (result.isLeft) return [];

    final String data = await _remoteStorageService.readRemoteFile(path: "Grupos", fileName: 'assets/grupos.json');

    final List<dynamic> json = jsonDecode(data);
    final List<Group> groups = json.map((e) => Group.fromJson(e)).toList();

    return groups;
  }

  @override
  Future<List<Group>> getGroups(BasicSearch search) {
    // TODO: implement getPictograms
    throw UnimplementedError();
  }

  @override
  Future<void> uploadGroups(List<Group> data, String type, String language, {String? userId}) async {
    final result = await _authService.getCurrentUser();
    if (result.isLeft) return;

    List<Map<String, dynamic>> jsonData = List.empty(growable: true);
    print(data.length);
    for (var e in data) {
      final relactions = e.relations.map((e) => e.toJson()).toList();
      // jsonData.add({
      //   'id': e.id,
      //   'texto': e.text.toJson(),
      //   'tipo': e.tipo,
      //   'imagen': e.imagen.toJson(),
      //   'relacion': relactions,
      //   'frecuencia': e.frecuencia,
      //   'tags': e.tags,
      // });
      //TODO: Fix this service :/
    }
    // print(jsonData.length);

    final UserModel auth = result.right;
    final res = await _serverRepository.uploadGroups(userId ?? auth.id, language, data: jsonData);
  }

  @override
  Future<void> updateGroups(Group data, String type, String language, int index, {String? userId}) async {
    final result = await _authService.getCurrentUser();
    if (result.isLeft) return;
    final UserModel auth = result.right;

    await _serverRepository.updateGroup(userId ?? auth.id, language, index, data: data.toMap());
  }

  @override
  Future<List<Group>> getDefaultGroups() {
    // TODO: implement getDefaultGroups
    throw UnimplementedError();
  }
}
