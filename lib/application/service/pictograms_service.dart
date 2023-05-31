import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

@Singleton(as: PictogramsRepository)
class PictogramsService extends PictogramsRepository {
  final AuthRepository _authService;
  final RemoteStorageRepository _remoteStorageService;
  final ServerRepository _serverRepository;
  final LocalStorageRepository _localStorageServices;

  PictogramsService(this._authService, this._serverRepository, this._remoteStorageService, this._localStorageServices);

  @override
  Future<List<Picto>> getAllPictograms() async {
    await Future.delayed(
      const Duration(seconds: kIsWeb ? 2 : 1),
    );

    final String data = await _remoteStorageService.readRemoteFile(path: "Pictos", fileName: 'assets/pictos.json');

    final List<dynamic> json = jsonDecode(data);
    final List<Picto> pictograms = json.map((e) => Picto.fromMap(e)).toList();

    return pictograms;
  }

  @override
  Future<List<Picto>> getPictograms(BasicSearch search) {
    // TODO: implement getPictograms
    throw UnimplementedError();
  }

  @override
  Future<void> uploadPictograms(List<Picto> data, String language, {String? userId}) async {
    List<Map<String, dynamic>> jsonData = List.empty(growable: true);
    for (var e in data) {
      jsonData.add(e.toMap());
    }
    final result = await _authService.getCurrentUser();
    if (result.isLeft) return;
    final UserModel auth = result.right;
    await _serverRepository.uploadPictograms(
      userId ?? auth.id,
      language,
      data: jsonData,
    );
  }

  @override
  Future<void> updatePictogram(Picto pictogram, String language, int index) async {
    final relactions = pictogram.relations.map((e) => e.toJson()).toList();

    final result = await _authService.getCurrentUser();

    if (result.isLeft) return;

    final String id = result.right.id;

    // await _serverRepository.updatePictogram(id, language, index, data: {
    //   'id': pictogram.id,
    //   'texto': pictogram.texto.toJson(),
    //   'tipo': pictogram.tipo,
    //   'imagen': pictogram.imagen.toJson(),
    //   'relacion': relactions,
    //   'agenda': pictogram.agenda,
    //   'gps': pictogram.gps,
    //   'hora': pictogram.hora,
    //   'edad': pictogram.edad,
    //   'sexo': pictogram.sexo,
    //   'esSugerencia': pictogram.esSugerencia,
    //   'horario': pictogram.horario,
    //   'ubicacion': pictogram.ubicacion,
    //   'score': pictogram.score,
    // });
  }

  @override
  Future<Map<String, String>> loadTranslations({required String language}) async {
    final pictosTranslations = await _localStorageServices.readPictosFromLocal(locale: language);
    return pictosTranslations.map((key, value) {
      return MapEntry(key, value["text"]);
    });
  }
}
