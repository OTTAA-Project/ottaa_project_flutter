import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:ottaa_project_flutter/core/models/groups_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';

class GroupsService extends GroupsRepository {
  final _databaseRef = FirebaseDatabase.instance.ref();

  final AuthRepository _authService;
  final RemoteStorageRepository _remoteStorageService;

  GroupsService(this._authService, this._remoteStorageService);

  @override
  Future<List<Grupos>> getAllGroups() async {
    await Future.delayed(
      const Duration(seconds: kIsWeb ? 2 : 1),
    );

    /// updated one for loading the pictos...
    /// check if data exists online or not
    final result = await _authService.getCurrentUser();
    if (result.isLeft) return [];
    final UserModel auth = result.right;
    debugPrint('the value from stream is ${auth.name}');
    // final ref = databaseRef.child('PictsExistsOnFirebase/${auth.uid}/');
    // final res = await ref.get();

    final String data = await _remoteStorageService.readRemoteFile(path: "Grupos", fileName: 'assets/grupos.json');

    final List<dynamic> json = jsonDecode(data);
    final List<Grupos> groups = json.map((e) => Grupos.fromJson(e)).toList();

    return groups;
  }

  @override
  Future<List<Grupos>> getGroups(BasicSearch search) {
    // TODO: implement getPictograms
    throw UnimplementedError();
  }

  @override
  Future<void> uploadGroups(List<Grupos> data, String type, String language) async {
    dynamic jsonData = List.empty(growable: true);
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
    final result = await _authService.getCurrentUser();
    if (result.isLeft) return;
    final UserModel auth = result.right;

    final ref = _databaseRef.child('${auth.id}/$type/$language');
    await ref.set(jsonData);
  }

  @override
  Future<void> updateGroups(Grupos data, String type, String language, int index) async {
    final result = await _authService.getCurrentUser();
    if (result.isLeft) return;
    final UserModel auth = result.right;
    final ref = _databaseRef.child('${auth.id}/$type/$language/$index');

    final relactions = data.relacion.map((e) => e.toJson()).toList();

    await ref.update({
      'id': data.id,
      'texto': data.texto.toJson(),
      'tipo': data.tipo,
      'imagen': data.imagen.toJson(),
      'relacion': relactions,
      'frecuencia': data.frecuencia,
      'tags': data.tags,
    });
  }
}
