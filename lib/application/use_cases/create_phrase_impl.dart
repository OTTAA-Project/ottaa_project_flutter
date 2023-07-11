import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/enums/board_data_type.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/use_cases/create_phrase_data.dart';

@Singleton(as: CreatePhraseData)
class CreatePhraseDataImpl extends CreatePhraseData {
  const CreatePhraseDataImpl(super.serverService);

  @override
  Future<String?> createPhraseData(
      {required Phrase phrase,
      required String userId,
      required String lang}) async {
    final response = await serverService.createPictoGroupData(
        userId: userId,
        language: lang,
        type: BoardDataType.phrases,
        data: phrase.toMap());

    if (response != null) {
      return response["data"]["dataId"] ?? response["code"];
    }

    return null;
  }
}
