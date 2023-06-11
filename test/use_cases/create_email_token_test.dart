import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/use_cases/create_email_token_impl.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'package:ottaa_project_flutter/core/use_cases/create_email_token.dart';

import '../service/auth/auth_service_test.mocks.dart';

void main() {
  late MockServerRepository mockServerRepository;
  late CreateEmailTokenImpl createEmailToken;

  setUpAll(() {
    mockServerRepository = MockServerRepository();

    createEmailToken = CreateEmailTokenImpl(mockServerRepository);
  });

  group("create email token", () {
    test("should create an token", () async {
      when(mockServerRepository.getEmailToken(any, any)).thenAnswer((realInvocation) async {
        return Right({});
      });

      final result = await createEmailToken.createEmailToken("emir@amil.com", "asim@mail.com");

      expect(result, null);
    });

    test("should return an error", () async {
      when(mockServerRepository.getEmailToken(any, any)).thenAnswer((realInvocation) async {
        return Left("error");
      });

      final result = await createEmailToken.createEmailToken("emir@amil.com", "asim@mail.com");

      expect(result, "error");
    });
  });
}
