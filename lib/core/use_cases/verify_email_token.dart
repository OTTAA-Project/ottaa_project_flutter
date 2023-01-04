import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class VerifyEmailToken {
  final ServerRepository serverService;

  const VerifyEmailToken(this.serverService);

  Future<bool> verifyEmailToken(String ownEmail, String email, String token);
}
