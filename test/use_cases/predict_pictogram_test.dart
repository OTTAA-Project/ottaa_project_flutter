import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/use_cases/predict_pictogram_impl.dart';

import '../service/about/about_service_test.mocks.dart';

void main() {
  late MockServerRepository mockServerRepository;
  late PredictPictogramImpl predictPictogramImpl;

  setUp(() {
    mockServerRepository = MockServerRepository();
    predictPictogramImpl = PredictPictogramImpl(serverRepository: mockServerRepository);
  });

  group("call", () {
    test("should predict reduced tokens", () async {
      when(mockServerRepository.predictPictogram(
        sentence: anyNamed("sentence"),
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        groups: anyNamed("groups"),
        tags: anyNamed("tags"),
        cancelToken: anyNamed("cancelToken"),
        reduced: anyNamed("reduced"),
      )).thenAnswer((realInvocation) async {
        return const Right({
          "data": [
            {
              "name": "hola",
              "id": {"id": "123"}
            }
          ]
        });
      });

      final result = await predictPictogramImpl(
        sentence: "hola",
        uid: "123",
        language: "en",
        model: "model",
        groups: [],
        tags: {},
        reduced: true,
      );

      expect(result.right, hasLength(1));
    });

    test("should predict tokens", () async {
      when(mockServerRepository.predictPictogram(
        sentence: anyNamed("sentence"),
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        groups: anyNamed("groups"),
        tags: anyNamed("tags"),
        cancelToken: anyNamed("cancelToken"),
        reduced: anyNamed("reduced"),
      )).thenAnswer((realInvocation) async {
        return const Right({
          "data": [
            {
              'name': "Hola",
              "id": {"id": "123"},
              'value': 3,
              'contextScore': 3,
              'tagScore': 3,
              'nameLength': 4,
              'nameSplitLength': 4,
            }
          ]
        });
      });

      final result = await predictPictogramImpl(
        sentence: "hola",
        uid: "123",
        language: "en",
        model: "model",
        groups: [],
        tags: {},
        reduced: true,
      );

      expect(result.right, hasLength(1));
    });

    test("should not predict tokens", () async {
      when(mockServerRepository.predictPictogram(
        sentence: anyNamed("sentence"),
        uid: anyNamed("uid"),
        language: anyNamed("language"),
        model: anyNamed("model"),
        groups: anyNamed("groups"),
        tags: anyNamed("tags"),
        cancelToken: anyNamed("cancelToken"),
        reduced: anyNamed("reduced"),
      )).thenAnswer((realInvocation) async {
        return const Left("Error");
      });

      final result = await predictPictogramImpl(
        sentence: "hola",
        uid: "123",
        language: "en",
        model: "model",
        groups: [],
        tags: {},
        reduced: true,
      );

      expect(result, isA<Left>());
    });
  });
}
