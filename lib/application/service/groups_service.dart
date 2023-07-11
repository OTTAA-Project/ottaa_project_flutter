import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

@Singleton(as: GroupsRepository)
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

    final String data = await _remoteStorageService.readRemoteFile(
      path: "groups",
      fileName: 'assets/grupos.json',
    );

    final List<dynamic> json = jsonDecode(data);
    final List<Group> groups = json.map((e) => Group.fromMap(e)).toList();

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

    for (var e in data) {
      jsonData.add(e.toMap());
    }

    final UserModel auth = result.right;
    await _serverRepository.uploadGroups(userId ?? auth.id, language, data: jsonData);
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
