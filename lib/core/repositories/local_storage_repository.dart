import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';

abstract class LocalStorageRepository {
  Future<Map<String, dynamic>> readPictosFromLocal({required String locale});
}
