import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:ottaa_project_flutter/core/use_cases/create_email_token.dart';

@Singleton(as: CreateEmailToken)
class CreateEmailTokenImpl extends CreateEmailToken {
  const CreateEmailTokenImpl(super.serverService);

  @override
  Future<String?> createEmailToken(String ownEmail, String email) async {
    final result = await serverService.getEmailToken(ownEmail, email);

    if (result.isLeft) {
      return result.left;
    }

    return null;
  }
}
