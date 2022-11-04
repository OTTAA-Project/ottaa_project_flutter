import 'package:ottaa_project_flutter/core/models/groups_model.dart';
import 'package:ottaa_project_flutter/core/models/pictogram_model.dart';

abstract class LocalStorageRepository {
  Future<void> writeGruposToFile({
    required String data,
    required String language,
  });

  Future<List<Grupos>> readGruposFromFile({
    required String language,
  });

  Future<void> writePictoToFile({required String data, required String language});

  Future<List<Pict>> readPictoFromFile({required String language});
}
