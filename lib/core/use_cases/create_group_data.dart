import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class CreateGroupData {
  final ServerRepository serverService;

  const CreateGroupData(this.serverService);

  Future<String?> createGroupData({required Group group, required String userId, required String lang});
}
