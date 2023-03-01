abstract class UserSettingRepository {
  Future<void> updateLanguageSettings(
      {required Map<String, dynamic> map, required String userId});

  Future<void> updateVoiceAndSubtitleSettings(
      {required Map<String, dynamic> map, required String userId});

  Future<void> updateAccessibilitySettings(
      {required Map<String, dynamic> map, required String userId});

  Future<void> updateMainSettings(
      {required Map<String, dynamic> map, required String userId});
}
