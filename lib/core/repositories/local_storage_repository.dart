import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';

abstract class LocalStorageRepository {
  Future<void> writeGruposToFile({
    required String data,
    required String language,
  });

  Future<List<Group>> readGruposFromFile({
    required String language,
  });

  Future<void> writePictoToFile({required String data, required String language});

  Future<List<Picto>> readPictoFromFile({required String language});
  Future<Map<String, dynamic>> readPictosFromLocal({required String locale});
}
