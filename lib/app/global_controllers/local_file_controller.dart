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
  Future<File> get _pictoFile async {
    final path = await _directoryPath;
    return File('$path/pictoFile.json');
  }

  Future<void> writeGruposToFile({required String data}) async {
    final file = await _gruposFile;
    await file.writeAsString(data);
  }

  Future<List<Grupos>> readGruposFromFile() async {
    final file = await _gruposFile;
    final response = await file.readAsString();
    return (jsonDecode(response) as List)
        .map((e) => Grupos.fromJson(e))
        .toList();
  }

  Future<void> writePictoToFile({required String data}) async {
    final file = await _pictoFile;
    await file.writeAsString(data);
  }

  Future<List<Pict>> readPictoFromFile() async {
    final file = await _pictoFile;
    final response = await file.readAsString();
    return (jsonDecode(response) as List)
        .map((e) => Pict.fromJson(e))
        .toList();
  }
}
