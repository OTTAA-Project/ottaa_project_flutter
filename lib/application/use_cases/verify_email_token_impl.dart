import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:ottaa_project_flutter/core/use_cases/verify_email_token.dart';

class VerifyEmailTokenImpl extends VerifyEmailToken {

  const VerifyEmailTokenImpl(super.serverService);

  @override
  Future<Either<String, String>> verifyEmailToken(String ownEmail, String email, String token) async {
    final result = await serverService.verifyEmailToken(ownEmail, email, token);

    if(result.isLeft){
      return Left(result.left);
    }

    return Right(result.right["data"]["userId"]);
  }
}
