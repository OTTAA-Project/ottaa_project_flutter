import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

class PictogramsService extends PictogramsRepository {
  final AuthRepository _authService;
  final RemoteStorageRepository _remoteStorageService;
  final ServerRepository _serverRepository;

  PictogramsService(this._authService, this._serverRepository, this._remoteStorageService);

  @override
  Future<List<Pict>> getAllPictograms() async {
    await Future.delayed(
      const Duration(seconds: kIsWeb ? 2 : 1),
    );

    final String data = await _remoteStorageService.readRemoteFile(path: "Pictos", fileName: 'assets/pictos.json');

    final List<dynamic> json = jsonDecode(data);
    final List<Pict> pictograms = json.map((e) => Pict.fromJson(e)).toList();

    return pictograms;
  }

  @override
  Future<List<Pict>> getPictograms(BasicSearch search) {
    // TODO: implement getPictograms
    throw UnimplementedError();
  }

  @override
  Future<void> uploadPictograms(List<Pict> data, String language) async {
    List<Map<String, dynamic>> jsonData = List.empty(growable: true);
    for (var e in data) {
      final relactions = e.relacion?.map((e) => e.toJson()).toList();
      jsonData.add({
        'id': e.id,
        'texto': e.texto.toJson(),
        'tipo': e.tipo,
        'imagen': e.imagen.toJson(),
        'relacion': relactions,
        'agenda': e.agenda,
        'gps': e.gps,
        'hora': e.hora,
        'edad': e.edad,
        'sexo': e.sexo,
        'esSugerencia': e.esSugerencia,
        'horario': e.horario,
        'ubicacion': e.ubicacion,
        'score': e.score,
      });
    }
    final result = await _authService.getCurrentUser();
    if (result.isLeft) return;
    final UserModel auth = result.right;

    await _serverRepository.uploadPictograms(
      auth.id,
      language,
      data: jsonData,
    );
  }

  @override
  Future<void> updatePictogram(Pict pictogram, String language, int index) async {
    final relactions = pictogram.relacion?.map((e) => e.toJson()).toList();

    final result = await _authService.getCurrentUser();

    if (result.isLeft) return;

    final String id = result.right.id;

    await _serverRepository.updatePictogram(id, language, index, data: {
      'id': pictogram.id,
      'texto': pictogram.texto.toJson(),
      'tipo': pictogram.tipo,
      'imagen': pictogram.imagen.toJson(),
      'relacion': relactions,
      'agenda': pictogram.agenda,
      'gps': pictogram.gps,
      'hora': pictogram.hora,
      'edad': pictogram.edad,
      'sexo': pictogram.sexo,
      'esSugerencia': pictogram.esSugerencia,
      'horario': pictogram.horario,
      'ubicacion': pictogram.ubicacion,
      'score': pictogram.score,
    });
  }
}
