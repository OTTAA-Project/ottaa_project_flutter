import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/use_cases/create_group_impl.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/use_cases/create_group_data.dart';

import '../service/auth/auth_service_test.mocks.dart';

void main() {
  late MockServerRepository serverRepository;
  late CreateGroupDataImpl createGroupData;

  setUpAll(() {
    serverRepository = MockServerRepository();

    createGroupData = CreateGroupDataImpl(serverRepository);
  });
  group("create group data", () {
    test("should create a group data", () async {
      when(serverRepository.createPictoGroupData(
        data: anyNamed("data"),
        language: anyNamed("language"),
        type: anyNamed("type"),
        userId: anyNamed("userId"),
      )).thenAnswer((realInvocation) async {
        return null;
      });

      final result = await createGroupData.createGroupData(group: Group(id: "", relations: [], text: "", resource: AssetsImage(asset: "asset", network: "network"), freq: 0), userId: "123", lang: "en");

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

      final result = await createGroupData.createGroupData(group: Group(id: "", relations: [], text: "", resource: AssetsImage(asset: "asset", network: "network"), freq: 0), userId: "123", lang: "en");

      expect(result, "123");
    });
  });
}
