import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/pictograms_service.dart';
import 'package:ottaa_project_flutter/core/abstracts/basic_search.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'pictograms_services_test.mocks.dart';

@GenerateMocks([
  AuthRepository,
  RemoteStorageRepository,
  ServerRepository,
  LocalStorageRepository,
])
Future<void> main() async {
  late MockAuthRepository mockAuthRepository;
  late MockRemoteStorageRepository mockRemoteStorageRepository;
  late MockServerRepository mockServerRepository;
  late MockLocalStorageRepository mockLocalStorageRepository;

  late PictogramsService pictogramsService;

  const String fakePictos = """
  [
    {
      "id": "-asGPzbBwFUWOXKvsKoLa",
      "resource": {
        "asset": "",
        "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Flila.webp?alt=media&token=3b380965-52f2-4529-846f-45cf1c4fdf9c"
      },
      "tags": {
        "EDAD": [
          "JOVEN",
          "NINO"
        ],
        "GENERO": [
          "MUJER"
        ]
      },
      "text": "lila",
      "type": 4
    },
    {
      "id": "-oI8IPzgalQuWwxWUS-ke",
      "resource": {
        "asset": "",
        "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Fsuyos.webp?alt=media&token=1265f18e-c7f5-4f94-852a-76c1f9841d25"
      },
      "tags": {
        "EDAD": [
          "ADULTO",
          "JOVEN"
        ]
      },
      "text": "suyos",
      "type": 6
    }
  ]
  """;

  BaseUserModel fakeUser = BaseUserModel(
    id: "0",
    settings: BaseSettingsModel(
      data: UserData(
        avatar: AssetsImage(asset: "test", network: "https://test.com"),
        birthDate: DateTime(0),
        genderPref: "n/a",
        lastConnection: DateTime(0),
        name: "John",
        lastName: "Doe",
      ),
      language: LanguageSetting.empty(),
    ),
    email: "test@mail.com",
    type: UserType.caregiver,
  );

  setUp(() async {
    mockAuthRepository = MockAuthRepository();
    mockRemoteStorageRepository = MockRemoteStorageRepository();
    mockServerRepository = MockServerRepository();
    mockLocalStorageRepository = MockLocalStorageRepository();

    pictogramsService = PictogramsService(
      mockAuthRepository,
      mockServerRepository,
      mockRemoteStorageRepository,
      mockLocalStorageRepository,
    );
  });

  test('should return all pictos', () async {
    when(mockRemoteStorageRepository.readRemoteFile(
      path: "Pictos",
      fileName: 'assets/pictos.json',
    )).thenAnswer((realInvocation) async => fakePictos);

    final pictos = await pictogramsService.getAllPictograms();
    expect(pictos.length, 2);
  });

  test('should return an empty list', () async {
    when(mockRemoteStorageRepository.readRemoteFile(
      path: 'Pictos',
      fileName: 'assets/pictos.json',
    )).thenAnswer((realInvocation) async => "[]");
    final pictos = await pictogramsService.getAllPictograms();
    expect(pictos, []);
  });

  test('should return an empty list', () async {
    final pictos = await pictogramsService.getPictograms(MockBasicSearch());

    expect(pictos, []);
  });

  group("Upload pictograms", () {
    test("should upload pictograms", () async {
      List<dynamic> fakePictosDB = [];

      when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Right(fakeUser));

      when(mockServerRepository.uploadPictograms(any, any, data: anyNamed("data"))).thenAnswer((realInvocation) async {
        fakePictosDB.addAll(realInvocation.namedArguments[#data]);

        return const Right(null);
      });
      final List<Picto> fakePictosJson = json.decode(fakePictos).map<Picto>((e) => Picto.fromMap(e)).toList();

      await pictogramsService.uploadPictograms(fakePictosJson, "es_AR");

      expect(fakePictosDB, hasLength(fakePictosJson.length));
    });

    test("should not upload groups", () async {
      List<dynamic> fakePictosDB = [];

      when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Left(""));

      await pictogramsService.uploadPictograms([], "es_AR");

      expect(fakePictosDB, hasLength(0));
    });
  });

  group("Update pictos", () {
    test("should NOT update pictos", () async {
      final List<Picto> fakeOriginalDB = json.decode(fakePictos).map<Picto>((e) => Picto.fromMap(e)).toList();
      final List<Picto> fakeDB = json.decode(fakePictos).map<Picto>((e) => Picto.fromMap(e)).toList();

      when(mockAuthRepository.getCurrentUser()).thenAnswer((realInvocation) async => Left(""));

      await pictogramsService.updatePictogram(fakeDB.first.copyWith(text: "HOLA"), "es_AR", 0);

      expect(fakeDB, hasLength(fakeOriginalDB.length));
    });

    test("should load translations", () async {
      final fakeTranslations = {
        "-4BLxgBogIdLJwbS00Mdz": {"text": "passeig"},
        "-Eakc1wdh0BBfhHZlkQhS": {"text": "baixar volum"},
      };

      when(mockLocalStorageRepository.readPictosFromLocal(locale: anyNamed("locale"))).thenAnswer((realInvocation) async {
        return fakeTranslations;
      });

      final result = await pictogramsService.loadTranslations(language: "es_AR");

      expect(result, fakeTranslations.map((key, value) {
        return MapEntry(key, value["text"]);
      }));
    });
  });
}

class MockBasicSearch extends BasicSearch {
  @override
  // TODO: implement asset
  String get asset => throw UnimplementedError();

  @override
  // TODO: implement file
  String get file => throw UnimplementedError();

  @override
  // TODO: implement language
  String get language => throw UnimplementedError();

  @override
  // TODO: implement remote
  String get remote => throw UnimplementedError();
}
