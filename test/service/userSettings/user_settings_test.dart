import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ottaa_project_flutter/application/service/user_settings_service.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

import 'user_settings_test.mocks.dart';

@GenerateMocks([ServerRepository])
void main() {
  late MockServerRepository mockServerRepository;
  late UserSettingsService userSettingsService;

  setUpAll(() {
    mockServerRepository = MockServerRepository();

    userSettingsService = UserSettingsService(mockServerRepository);
  });

  test("should update language settings", () async {
    final map = {"key": "value"};
    final userId = "userId";
    when(userSettingsService.updateLanguageSettings(map: map, userId: userId)).thenAnswer((_) async => {});
    await userSettingsService.updateLanguageSettings(map: map, userId: userId);

    verify(mockServerRepository.updateLanguageSettings(map: map, userId: userId));
  });

  test("should update voice and subtitle settings", () async {
    final map = {"key": "value"};
    final userId = "userId";
    when(userSettingsService.updateVoiceAndSubtitleSettings(map: map, userId: userId)).thenAnswer((_) async => {});
    await userSettingsService.updateVoiceAndSubtitleSettings(map: map, userId: userId);

    verify(mockServerRepository.updateVoiceAndSubtitleSettings(map: map, userId: userId));
  });

  test("should update accessibility settings", () async {
    final map = {"key": "value"};
    final userId = "userId";
    when(userSettingsService.updateAccessibilitySettings(map: map, userId: userId)).thenAnswer((_) async => {});
    await userSettingsService.updateAccessibilitySettings(map: map, userId: userId);

    verify(mockServerRepository.updateAccessibilitySettings(map: map, userId: userId));
  });

  test("should update main settings", () async {
    final map = {"key": "value"};
    final userId = "userId";
    when(mockServerRepository.updateMainSettings(map: map, userId: userId)).thenAnswer((_) async => {});
    await userSettingsService.updateMainSettings(map: map, userId: userId);

    verify(mockServerRepository.updateMainSettings(map: map, userId: userId));
  });

  test("should fetch user settings", () async {
    final userId = "userId";
    when(mockServerRepository.fetchUserSettings(userId: userId)).thenAnswer((_) async => {});
    await userSettingsService.fetchUserSettings(userId: userId);

    verify(mockServerRepository.fetchUserSettings(userId: userId));
  });
}
