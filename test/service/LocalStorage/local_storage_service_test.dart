import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:either_dart/src/either.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/local_storage_service.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';
const String kAssetsPath = './';

void main() {
  LocalStorageService localStorageService = LocalStorageService();
  setUpAll(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    TestWidgetsFlutterBinding.ensureInitialized();
    // expose path_provider
  });
  // group('Test Local Storage Service ', () {
  //   group('Test es-AR', () {
  //     test('Write Groups ES', () async {
  //       String result = await rootBundle.loadString('assets/gender_based/grupos/grupos_es_male.json');
  //       await localStorageService.writeGruposToFile(data: result, language: 'es_AR');
  //     });
  //     test('Read Groups ES', () async {
  //       List esG = await localStorageService.readGruposFromFile(language: 'es_AR');
  //       print(esG);
  //     });
  //     test('WritePictograms ES', () async {
  //       String result = await rootBundle.loadString('assets/gender_based/pictos/pictos_es_male.json');
  //       await localStorageService.writePictoToFile(data: result, language: 'es_AR');
  //     });
  //     test('Read Pictograms ES', () async {
  //       List esG = await localStorageService.readPictoFromFile(language: 'es_AR');
  //       print(esG);
  //     });
  //   });
  //   group('Test en-US', () {
  //     test('Write Groups EN', () async {
  //       String result = await rootBundle.loadString('assets/grupos.json');
  //       await localStorageService.writeGruposToFile(data: result, language: 'en-US');
  //     });
  //     test('Read Groups EN', () async {
  //       List en = await localStorageService.readGruposFromFile(language: 'en-US');
  //       print(en);
  //     });
  //     test('Read Pictos EN', () async {
  //       String result = await rootBundle.loadString('assets/pictos.json');
  //       await localStorageService.writePictoToFile(data: result, language: 'en-US');
  //     });
  //     test('Read Pictos EN', () async {
  //       List en = await localStorageService.readPictoFromFile(language: 'en-US');
  //       print(en);
  //     });
  //   });
  //   group('Test fr-FR', () {
  //     test('Write Groups fr', () async {
  //       String result = await rootBundle.loadString('assets/languages/grupos_fr.json');
  //       await localStorageService.writeGruposToFile(data: result, language: 'fr-FR');
  //     });
  //     test('Read Groups fr', () async {
  //       List en = await localStorageService.readGruposFromFile(language: 'fr-FR');
  //       print(en);
  //     });
  //     test('Write Pictos fr', () async {
  //       String result = await rootBundle.loadString('assets/languages/pictos_fr.json');
  //       await localStorageService.writePictoToFile(data: result, language: 'fr-FR');
  //     });
  //     test('Read Pictos fr', () async {
  //       List en = await localStorageService.readPictoFromFile(language: 'fr-FR');
  //       print(en);
  //     });
  //   });
  //   group('Test pt-BR', () {
  //     test('Write Groups pt', () async {
  //       String result = await rootBundle.loadString('assets/languages/grupos_pt.json');
  //       await localStorageService.writeGruposToFile(data: result, language: 'pt-BR');
  //     });
  //     test('Read Groups pt', () async {
  //       List en = await localStorageService.readGruposFromFile(language: 'pt-BR');
  //       print(en);
  //     });
  //     test('Write Pictos pt', () async {
  //       String result = await rootBundle.loadString('assets/languages/pictos_pt.json');
  //       await localStorageService.writePictoToFile(data: result, language: 'pt-BR');
  //     });
  //     test('Read Pictos pt', () async {
  //       List en = await localStorageService.readPictoFromFile(language: 'pt-BR');
  //       print(en);
  //     });
  //   });
  //   group('Test default', () {
  //     test('Write Groups IT', () async {
  //       String result = await rootBundle.loadString('assets/grupos.json');
  //       await localStorageService.writeGruposToFile(data: result, language: 'it-IT');
  //     });
  //     test('Read Groups IT', () async {
  //       List en = await localStorageService.readGruposFromFile(language: 'it-IT');
  //       print(en);
  //     });
  //     test('Read Pictos IT', () async {
  //       String result = await rootBundle.loadString('assets/pictos.json');
  //       await localStorageService.writePictoToFile(data: result, language: 'it-IT');
  //     });
  //     test('Read Pictos IT', () async {
  //       List en = await localStorageService.readPictoFromFile(language: 'it-IT');
  //       print(en);
  //     });
  //   });
  // });
}

class FakePathProviderPlatform extends Fake with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}

class AllNullFakePathProviderPlatform extends Fake with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return null;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return null;
  }

  @override
  Future<String?> getLibraryPath() async {
    return null;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return null;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return null;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return null;
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return null;
  }

  @override
  Future<String?> getDownloadsPath() async {
    return null;
  }
}
