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

import 'local_storage_service_test.mocks.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';
const String kAssetsPath = './';

@GenerateMocks([PathProviderPlatform, AssetBundle])
void main() {
  late MockAssetBundle mockAssetBundle;
  late LocalStorageService localStorageService;
  setUp(() {
    mockAssetBundle = MockAssetBundle();

    localStorageService = LocalStorageService(assetBundler: mockAssetBundle);
  });

  test("factory method", () {
    expect(LocalStorageService.start(), isA<LocalStorageService>());

  });
  test("read pictos from local should return a map", () async {
    when(mockAssetBundle.loadString(any)).thenAnswer((realInvocation) async {
      return '{"pictos": []}';
    });

    final map = await localStorageService.readPictosFromLocal(locale: "es_AR");

    expect(map, isA<Map<String, dynamic>>());
    verify(mockAssetBundle.loadString(any));
  });
}
