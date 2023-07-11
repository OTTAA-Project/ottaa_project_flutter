import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/enums/board_data_type.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/use_cases/create_picto_data.dart';

@Singleton(as: CreatePictoData)
class CreatePictoDataImpl extends CreatePictoData {
  const CreatePictoDataImpl(super.serverService);

  @override
  Future<String?> createPictoData(
      {required Picto picto,
      required String userId,
      required String lang}) async {
    final response = await serverService.createPictoGroupData(
        userId: userId,
        language: lang,
        type: BoardDataType.pictos,
        data: picto.toMap());

    if (response != null) {
      return response["data"]["dataId"] ?? response["code"];
    }

    return null;
  }
}
