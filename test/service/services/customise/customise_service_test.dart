import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/service.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'customise_service_test.mocks.dart';

@GenerateMocks([
  ServerRepository,
])
void main() {
  late MockServerRepository mockServerRepository;

  late CustomiseService customiseService;
  final fakePictos = {
    "FWy18PiX2jLwZQF6-oNZR": {
      "id": "FWy18PiX2jLwZQF6-oNZR",
      "relations": [],
      "resource": {"asset": "", "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Fic_action_previous.webp?alt=media&token=a6feccd4-fd34-4b5a-ac1d-a5f027551d44"},
      "tags": {
        "EDAD": ["JOVEN", "NINO"]
      },
      "text": "%null%",
      "type": 2
    },
    "FWy18PiX2jLwZQF6-oNZR1": {
      "id": "FWy18PiX2jLwZQF6-oNZR",
      "relations": [],
      "resource": {"asset": "", "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Fic_action_previous.webp?alt=media&token=a6feccd4-fd34-4b5a-ac1d-a5f027551d44"},
      "tags": {
        "EDAD": ["JOVEN", "NINO"]
      },
      "text": "%null%",
      "type": 2
    },
  };

  final Map<String, Map<String, dynamic>> fakeGroups = {
    "--PHmDIFeKHvulVxNtBgk": {
      "freq": 0,
      "id": "--PHmDIFeKHvulVxNtBgk",
      "relations": [],
      "resource": {"asset": "", "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Fdescripcion.webp?alt=media&token=4dbde8ba-f144-4a12-90f6-013bf68d912d"},
      "text": "ADJETIVOS"
    },
    "--PHmDIFeKHvulVxNtBgk1": {
      "freq": 0,
      "id": "--PHmDIFeKHvulVxNtBgk1",
      "relations": [],
      "resource": {"asset": "", "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Fdescripcion.webp?alt=media&token=4dbde8ba-f144-4a12-90f6-013bf68d912d"},
      "text": "ADJETIVOS1"
    }
  };

  final fakeShorcuts = ShortcutsModel.none();

  setUp(() {
    mockServerRepository = MockServerRepository();

    customiseService = CustomiseService(mockServerRepository);
  });

  test("should set shortcuts for user", () async {
    ShortcutsModel? shortcuts;

    when(mockServerRepository.setShortcutsForUser(shortcuts: ShortcutsModel.none(), userId: "")).thenAnswer((realInvocation) async {
      shortcuts = realInvocation.namedArguments[#shortcuts];

      return Right("");
    });

    await customiseService.setShortcutsForUser(shortcuts: ShortcutsModel.none(), userId: "");

    expect(shortcuts, ShortcutsModel.none());
  });

  test("should return the defaults groups", () async {
    when(mockServerRepository.getDefaultGroups(any)).thenAnswer((_) async {
      return Right(fakeGroups);
    });

    final groups = await customiseService.fetchDefaultGroups(languageCode: "");

    expect(groups.length, 2);
  });

  test("should return the default pictos", () async {
    when(mockServerRepository.getDefaultPictos(any)).thenAnswer((_) async {
      return Right(fakePictos);
    });

    final pictos = await customiseService.fetchDefaultPictos(languageCode: "");

    expect(pictos.length, 2);
  });

  test("should return the shortcuts", () async {
    when(mockServerRepository.fetchShortcutsForUser(userId: "")).thenAnswer((_) async {
      return Right(fakeShorcuts.toMap());
    });

    final shortcuts = await customiseService.fetchShortcutsForUser(userId: "");

    expect(shortcuts, fakeShorcuts);
  });

  test("should return a list of user groups", () async {
    when(mockServerRepository.fetchUserGroups(languageCode: "", userId: "")).thenAnswer((_) async {
      return Right(fakeGroups);
    });

    final groups = await customiseService.fetchUserGroups(languageCode: "", userId: "");

    expect(groups.length, 2);
  });

  test("should return a list of user pictos", () async {
    when(mockServerRepository.fetchUserPictos(languageCode: "", userId: "")).thenAnswer((_) async {
      return Right(fakePictos);
    });

    final pictos = await customiseService.fetchUserPictos(languageCode: "", userId: "");

    expect(pictos.length, 2);
  });

  test("should return if a value exist or not", () async {
    when(mockServerRepository.fetchUserGroups(languageCode: "", userId: "")).thenAnswer((_) async {
      return Right(fakeGroups);
    });

    final exist = await customiseService.valuesExistOrNot(languageCode: "", userId: "");

    expect(exist, true);
  });
}
