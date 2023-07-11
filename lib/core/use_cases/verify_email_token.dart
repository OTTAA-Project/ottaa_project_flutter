import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';

abstract class VerifyEmailToken {
  final ServerRepository serverService;

  const VerifyEmailToken(this.serverService);

  Future<Either<String, String>> verifyEmailToken(
      String ownEmail, String email, String token);
}
