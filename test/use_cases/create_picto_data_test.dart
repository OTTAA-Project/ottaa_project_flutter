import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/use_cases/create_group_impl.dart';
import 'package:ottaa_project_flutter/application/use_cases/create_phrase_impl.dart';
import 'package:ottaa_project_flutter/application/use_cases/create_picto_impl.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/use_cases/create_group_data.dart';
import 'package:ottaa_project_flutter/core/use_cases/use_cases.dart';

import '../service/auth/auth_service_test.mocks.dart';

void main() {
  late MockServerRepository serverRepository;
  late CreatePictoDataImpl createPhraseData;

  setUpAll(() {
    serverRepository = MockServerRepository();

    createPhraseData = CreatePictoDataImpl(serverRepository);
  });
  group("create picto data", () {
    test("should create a picto data", () async {
      when(serverRepository.createPictoGroupData(
        data: anyNamed("data"),
        language: anyNamed("language"),
        type: anyNamed("type"),
        userId: anyNamed("userId"),
      )).thenAnswer((realInvocation) async {
        return null;
      });

      final result = await createPhraseData.createPictoData(
        picto: Picto(id: "123", type: 3, resource: AssetsImage(asset: "asset", network: "network")),
        userId: "123",
        lang: "en",
      );

      expect(result, null);
    });

    test("should return an error", () async {
      when(serverRepository.createPictoGroupData(
        data: anyNamed("data"),
        language: anyNamed("language"),
        type: anyNamed("type"),
        userId: anyNamed("userId"),
      )).thenAnswer((realInvocation) async {
        return {
          "data": {"dataId": "123"}
        };
      });
      final result = await createPhraseData.createPictoData(
        picto: Picto(id: "123", type: 3, resource: AssetsImage(asset: "asset", network: "network")),
        userId: "123",
        lang: "en",
      );

      expect(result, "123");
    });
  });
}
