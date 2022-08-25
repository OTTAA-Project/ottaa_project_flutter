import 'dart:convert';
import 'dart:io';

import 'package:ottaa_project_flutter/app/data/models/grupos_model.dart';
import 'package:ottaa_project_flutter/app/data/models/pict_model.dart';
import 'package:path_provider/path_provider.dart';

class LocalFileController {
  static LocalFileController? _instance;

  LocalFileController._internal();

  factory LocalFileController() =>
      _instance ??= LocalFileController._internal();

  Future<String> get _directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _gruposFile async {
    final path = await _directoryPath;
    return File('$path/gruposFile.json');
  }

  Future<File> get _gruposFrenchFile async {
    final path = await _directoryPath;
    return File('$path/grupos_fr_file.json');
  }

  Future<File> get _gruposPortugueseFile async {
    final path = await _directoryPath;
    return File('$path/grupos_fr_file.json');
  }

  Future<File> get _pictoFile async {
    final path = await _directoryPath;
    return File('$path/pictoFile.json');
  }

  Future<File> get _pictoFrenchFile async {
    final path = await _directoryPath;
    return File('$path/pictos_fr_file.json');
  }

  Future<File> get _pictoPortugueseFile async {
    final path = await _directoryPath;
    return File('$path/pictos_pt_file.json');
  }

  Future<void> writeGruposToFile({
    required String data,
    required String language,
  }) async {
    // final file = await _gruposFile;
    late File file;
    switch (language) {
      case "es-AR":
        file = await _gruposFile;
        break;
      case "en-US":
        file = await _gruposFile;
        break;
      case "fr-FR":
        file = await _gruposFrenchFile;
        break;
      case "pt-BR":
        file = await _gruposPortugueseFile;
        break;
      default:
        file = await _gruposFile;
    }
    await file.writeAsString(data);
  }

  Future<List<Grupos>> readGruposFromFile({
    required String language,
  }) async {
    // final File file = await _gruposFile;
    late File file;
    switch (language) {
      case "es-AR":
        file = await _gruposFile;
        break;
      case "en-US":
        file = await _gruposFile;
        break;
      case "fr-FR":
        file = await _gruposFrenchFile;
        break;
      case "pt-BR":
        file = await _gruposPortugueseFile;
        break;
      default:
        file = await _gruposFile;
    }
    final response = await file.readAsString();
    return (jsonDecode(response) as List)
        .map((e) => Grupos.fromJson(e))
        .toList();
  }

  Future<void> writePictoToFile(
      {required String data, required String language}) async {
    // final file = await _pictoFile;
    late File file;
    switch (language) {
      case "es-AR":
        file = await _pictoFile;
        break;
      case "en-US":
        file = await _pictoFile;
        break;
      case "fr-FR":
        file = await _pictoFrenchFile;
        break;
      case "pt-BR":
        file = await _pictoPortugueseFile;
        break;
      default:
        file = await _pictoFile;
    }
    await file.writeAsString(data);
  }

  Future<List<Pict>> readPictoFromFile({required String language}) async {
    // final file = await _pictoFile;
    late File file;
    switch (language) {
      case "es-AR":
        file = await _pictoFile;
        break;
      case "en-US":
        file = await _pictoFile;
        break;
      case "fr-FR":
        file = await _pictoFrenchFile;
        break;
      case "pt-BR":
        file = await _pictoPortugueseFile;
        break;
      default:
        file = await _pictoFile;
    }
    final response = await file.readAsString();
    return (jsonDecode(response) as List).map((e) => Pict.fromJson(e)).toList();
  }
}
