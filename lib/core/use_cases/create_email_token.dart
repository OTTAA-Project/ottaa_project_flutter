 import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class CreateEmailToken {
  final ServerRepository serverService;

  const CreateEmailToken(this.serverService);

  Future<String?> createEmailToken(String ownEmail, String email);
}
