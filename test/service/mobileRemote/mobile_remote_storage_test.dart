import 'dart:convert';
import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/service/service.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/tts_setting.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'package:universal_io/io.dart';

import 'mobile_remote_storage_test.mocks.dart';

@GenerateMocks([AuthRepository, ServerRepository, I18N, AssetBundle])
void main() {
  late FirebaseStorage firebaseDatabase;
  late MockAuthRepository mockAuthRepository;
  late MockServerRepository mockServerRepository;
  late MockI18N mockI18N;
  late MockAssetBundle mockAssetBundle;

  late RemoteStorageService mobileRemoteStorageService;
  const Map<String, dynamic> fakeGroup = {
    "block": false,
    "freq": 0,
    "id": "--PHmDIFeKHvulVxNtBgk",
    "relations": [],
    "resource": {"asset": "", "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Fdescripcion.webp?alt=media&token=4dbde8ba-f144-4a12-90f6-013bf68d912d"},
    "text": "ADJETIVOS"
  };
  const Map<String, dynamic> fakePicto = {
    "block": false,
    "freq": 0,
    "id": "ZodvGgP2un6y5X185Xrb9",
    "resource": {"asset": "", "network": "https://firebasestorage.googleapis.com/v0/b/ottaaproject-flutter.appspot.com/o/Archivos%20Paises%2Ficonos%2Fgallo.webp?alt=media&token=f7eeb656-0122-4522-a795-630b90749f8a"},
    "text": "gallo",
    "type": 2
  };

  final Map<String, dynamic> fakeUserInfo = {
    "id": "mu4ZiTMURBeLEV7p3CrFbljBrHF2",
    "pictos": {},
    "groups": {},
    "settings": {
      "data": {
        "avatar": {"asset": "671", "network": "123"},
        "birthDate": 0,
        "genderPref": "n/a",
        "lastConnection": 1684420759838,
        "lastName": "Ali",
        "name": "Emir",
        "number": ""
      },
      "devices": [],
      "tts": TTSSetting.empty().toMap(),
      "language": {
        "labs": false,
        "language": "es_AR",
      },
      "layout": {
        "cleanup": true,
        "display": "tab",
        "oneToOne": false,
        "shortcuts": {"camera": false, "enable": true, "favs": false, "games": true, "history": false, "no": true, "share": false, "yes": true}
      },
      "payment": {"payment": false, "paymentDate": 0, "paymentExpire": 0}
    },
    "type": "user"
  };

  final fakeUserModel = PatientUserModel.fromMap(fakeUserInfo);

  setUp(() {
    firebaseDatabase = MockFirebaseStorage();
    mockAuthRepository = MockAuthRepository();
    mockServerRepository = MockServerRepository();
    mockI18N = MockI18N();
    mockAssetBundle = MockAssetBundle();

    mobileRemoteStorageService = RemoteStorageService(mockAuthRepository, mockServerRepository, mockI18N, firebaseStorage: firebaseDatabase, assetBundle: mockAssetBundle);
  });

  // test("should create instance with default injectors", () {
  //   final service = MobileRemoteStorageService.from(mockAuthRepository, mockServerRepository, mockI18N);

  //   expect(service, isNotNull);
  // });

  test("delete file should throw an exception", () async {
    expect(() => mobileRemoteStorageService.deleteFile("path", "fileName"), throwsUnimplementedError);
  });

  group("read remote file", () {
    test("should return empty string if user is not logged in", () async {
      when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Left(""));

      final result = await mobileRemoteStorageService.readRemoteFile(path: "path", fileName: "fileName");

      expect(result, "");
    });

    test("should return pictos if user is logged in", () async {
      when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUserModel));
      when(mockI18N.currentLocale).thenReturn(const Locale("es_AR"));
      when(mockServerRepository.getAllPictograms(any, any)).thenAnswer((_) async => Right([fakePicto]));

      final result = await mobileRemoteStorageService.readRemoteFile(path: "Pictos", fileName: "fileName");

      expect(result, jsonEncode([fakePicto]));
    });

    test("should return groups if user is logged in", () async {
      when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUserModel));
      when(mockI18N.currentLocale).thenReturn(const Locale("es_AR"));
      when(mockServerRepository.getAllGroups(any, any)).thenAnswer((_) async => Right([fakeGroup]));

      final result = await mobileRemoteStorageService.readRemoteFile(path: "Grupos", fileName: "fileName");

      expect(result, jsonEncode([fakeGroup]));
    });

    test("should return cached pictos", () async {
      when(mockAuthRepository.getCurrentUser()).thenAnswer((_) async => Right(fakeUserModel));
      when(mockI18N.currentLocale).thenReturn(const Locale("es_AR"));
      when(mockServerRepository.getAllPictograms(any, any)).thenAnswer((_) async => Left("No pictos"));

      when(mockAssetBundle.loadString(any)).thenAnswer((_) async => jsonEncode([fakePicto]));

      final result = await mobileRemoteStorageService.readRemoteFile(path: "Pictos", fileName: "pictos_path");

      expect(result, jsonEncode([fakePicto]));
    });
  });

  test("should upload file", () async {
    String uploadFileURL = await mobileRemoteStorageService.uploadFile("path", "fileName", Uint8List.fromList([1, 2, 3]));

    expect(uploadFileURL, isA<String>());
  });
}
