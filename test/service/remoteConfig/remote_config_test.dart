import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/remote_config_service.dart';

import '../notifications/firebase_messaging_mock.dart';
import 'remote_config_test.mocks.dart';

@GenerateMocks([FirebaseRemoteConfig])
void main() async {
  setupFirebaseMessagingMocks();

  late MockFirebaseRemoteConfig mockFirebaseRemoteConfig;
  late RemoteConfigService remoteConfigService;
  setUp(() async {
    await Firebase.initializeApp();
    mockFirebaseRemoteConfig = MockFirebaseRemoteConfig();

    remoteConfigService = RemoteConfigService(remoteConfig: mockFirebaseRemoteConfig);
  });

  test("should init Firebase Remote Config", () async {
    when(mockFirebaseRemoteConfig.setConfigSettings(any)).thenAnswer((realInvocation) async {});

    final result = await remoteConfigService.init();

    verify(mockFirebaseRemoteConfig.setConfigSettings(any));
    expect(result, remoteConfigService);
  });

  test("should get bool value", () async {
    when(mockFirebaseRemoteConfig.getBool(any)).thenReturn(true);

    final result = await remoteConfigService.getBool("key");

    verify(mockFirebaseRemoteConfig.getBool(any));
    expect(result, true);
  });

  test("should get double value", () async {
    when(mockFirebaseRemoteConfig.getDouble(any)).thenReturn(1.0);

    final result = await remoteConfigService.getDouble("key");

    verify(mockFirebaseRemoteConfig.getDouble(any));
    expect(result, 1.0);
  });

  test("should get int value", () async {
    when(mockFirebaseRemoteConfig.getInt(any)).thenReturn(1);

    final result = await remoteConfigService.getInt("key");

    verify(mockFirebaseRemoteConfig.getInt(any));
    expect(result, 1);
  });

  test("should get string value", () async {
    when(mockFirebaseRemoteConfig.getString(any)).thenReturn("value");

    final result = await remoteConfigService.getString("key");

    verify(mockFirebaseRemoteConfig.getString(any));
    expect(result, "value");
  });
}
