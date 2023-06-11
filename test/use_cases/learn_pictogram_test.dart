import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/use_cases/learn_pictogram_impl.dart';

import '../service/auth/auth_service_test.mocks.dart';

void main() {
  late MockServerRepository mockServerRepository;
  late LearnPictogramImpl learnPictogramImpl;

  setUp(() {
    mockServerRepository = MockServerRepository();
    learnPictogramImpl = LearnPictogramImpl(serverRepository: mockServerRepository);
  });

  group("call", () {
    test("should learn tokens", () async {
      when(mockServerRepository.learnPictograms(
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        tokens: anyNamed("tokens"),
      )).thenAnswer((realInvocation) async {
        return Right({"time": "123"});
      });

      final result = await learnPictogramImpl(
        uid: "123",
        language: "en",
        model: "model",
        tokens: [],
      );

      expect(result, Right("123"));
    });

    test("should not learn tokens", () async {
      when(mockServerRepository.learnPictograms(
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        tokens: anyNamed("tokens"),
      )).thenAnswer((realInvocation) async {
        return Left("error");
      });

      final result = await learnPictogramImpl(
        uid: "123",
        language: "en",
        model: "model",
        tokens: [],
      );

      expect(result, Left("error"));
    });
  });
}