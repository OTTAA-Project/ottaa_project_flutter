import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:ottaa_project_flutter/core/use_cases/verify_email_token.dart';

class VerifyEmailTokenImpl implements VerifyEmailToken {
  @override
  final ServerRepository serverService;

  const VerifyEmailTokenImpl(this.serverService);

  @override
  Future<String?> verifyEmailToken(String ownEmail, String email, String token) async {
    final result = await serverService.verifyEmailToken(ownEmail, email, token);

    return result.fold(
      (l) => l,
      (r) => null,
    );
  }
}
