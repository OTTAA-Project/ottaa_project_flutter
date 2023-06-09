import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/pictograms_service.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
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
}
