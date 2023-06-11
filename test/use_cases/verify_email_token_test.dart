import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/use_cases/verify_email_token_impl.dart';

import '../service/auth/auth_service_test.mocks.dart';

void main() {
  late MockServerRepository serverRepository;
  late VerifyEmailTokenImpl verifyEmailTokenImpl;

  setUp(() {
    serverRepository = MockServerRepository();
    verifyEmailTokenImpl = VerifyEmailTokenImpl(serverRepository);
  });

  group("verify email token", () {
    test("should verify email token", () async {
      when(serverRepository.verifyEmailToken(
        any,
        any,
        any,
      )).thenAnswer((realInvocation) async {
        return const Right({
          "data": {"userId": "123"}
        });
      });

      final result = await verifyEmailTokenImpl.verifyEmailToken(
        "123",
        "123",
        "123",
      );

      expect(result.right, "123");
    });

    test("should not verify email token", () async {
      when(serverRepository.verifyEmailToken(
        any,
        any,
        any,
      )).thenAnswer((realInvocation) async {
        return const Left("error");
      });

      final result = await verifyEmailTokenImpl.verifyEmailToken(
        "123",
        "123",
        "123",
      );

      expect(result.left, "error");
    });
  });
}
