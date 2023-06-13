import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/enums/board_data_type.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/use_cases/create_group_data.dart';

@Singleton(as: CreateGroupData)
class CreateGroupDataImpl extends CreateGroupData {
  const CreateGroupDataImpl(super.serverService);

  @override
  Future<String?> createGroupData({required Group group, required String userId, required String lang}) async {
    final response = await serverService.createPictoGroupData(userId: userId, language: lang, type: BoardDataType.groups, data: group.toMap());

    if (response != null) {
      return response["data"]["dataId"] ?? response["code"];
    }

    return null;
  }
}
