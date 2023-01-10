import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ottaa_project_flutter/core/models/groups_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class GroupsService extends GroupsRepository {
  final AuthRepository _authService;
  final RemoteStorageRepository _remoteStorageService;
  final ServerRepository _serverRepository;

  GroupsService(
      this._authService, this._remoteStorageService, this._serverRepository);

  @override
  Future<List<Groups>> getAllGroups({bool defaultGroups = false}) async {
    await Future.delayed(
      const Duration(seconds: kIsWeb ? 2 : 1),
    );

    final result = await _authService.getCurrentUser();
    if (result.isLeft) return [];

    final String data = await _remoteStorageService.readRemoteFile(
        path: "Grupos", fileName: 'assets/grupos.json');

    final List<dynamic> json = jsonDecode(data);
    final List<Groups> groups = json.map((e) => Groups.fromJson(e)).toList();

    return groups;
  }

  @override
  Future<List<Groups>> getGroups(BasicSearch search) {
    // TODO: implement getPictograms
    throw UnimplementedError();
  }

  @override
  Future<void> uploadGroups(List<Groups> data, String type, String language,
      {String? userId}) async {
    final result = await _authService.getCurrentUser();
    if (result.isLeft) return;

    List<Map<String, dynamic>> jsonData = List.empty(growable: true);
    print(data.length);
    for (var e in data) {
      final relactions = e.relacion.map((e) => e.toJson()).toList();
      jsonData.add({
        'id': e.id,
        'texto': e.texto.toJson(),
        'tipo': e.tipo,
        'imagen': e.imagen.toJson(),
        'relacion': relactions,
        'frecuencia': e.frecuencia,
        'tags': e.tags,
      });
    }
    print(jsonData.length);

    final UserModel auth = result.right;
    await _serverRepository.uploadGroups(userId ?? auth.id, language,
        data: jsonData);
  }

  @override
  Future<void> updateGroups(
      Groups data, String type, String language, int index) async {
    final result = await _authService.getCurrentUser();
    if (result.isLeft) return;
    final UserModel auth = result.right;

    final relactions = data.relacion.map((e) => e.toJson()).toList();

    final payload = {
      'id': data.id,
      'texto': data.texto.toJson(),
      'tipo': data.tipo,
      'imagen': data.imagen.toJson(),
      'relacion': relactions,
      'frecuencia': data.frecuencia,
      'tags': data.tags,
    };

    await _serverRepository.updateGroup(auth.id, language, index,
        data: payload);
  }

  @override
  Future<List<Groups>> getDefaultGroups() {
    // TODO: implement getDefaultGroups
    throw UnimplementedError();
  }
}
