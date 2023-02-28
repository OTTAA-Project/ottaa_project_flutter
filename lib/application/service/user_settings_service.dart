import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/user_settings_repository.dart';

@Singleton(as: UserSettingRepository)
class UserSettingsService extends UserSettingRepository {
  final ServerRepository _serverRepository;

  UserSettingsService(this._serverRepository);

  @override
  Future<void> updateLanguageSettings(
      {required Map<String, dynamic> map, required String userId}) async {
    _serverRepository.updateLanguageSettings(map: map, userId: userId);
  }

  @override
  Future<void> updateVoiceAndSubtitleSettings(
      {required Map<String, dynamic> map, required String userId}) async {
    _serverRepository.updateVoiceAndSubtitleSettings(map: map, userId: userId);
  }

  @override
  Future<void> updateAccessibilitySettings(
      {required Map<String, dynamic> map, required String userId}) async {
    _serverRepository.updateAccessibilitySettings(map: map, userId: userId);
  }
}
