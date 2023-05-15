import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class CreatePhraseData {
  final ServerRepository serverService;

  const CreatePhraseData(this.serverService);

  Future<String?> createPhraseData(
      {required Phrase phrase, required String userId, required String lang});
}
