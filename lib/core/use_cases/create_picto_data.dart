import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class CreatePictoData {
  final ServerRepository serverService;

  const CreatePictoData(this.serverService);

  Future<String?> createPictoData(
      {required Picto picto, required String userId, required String lang});
}
