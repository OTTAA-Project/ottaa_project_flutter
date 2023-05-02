import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_config_repository.dart';

@Singleton(
  as: RemoteConfigRepository,
)
class RemoteConfigService extends RemoteConfigRepository {
  final _remoteConfig = FirebaseRemoteConfig.instance;

  @FactoryMethod(
    preResolve: true,
  )
  static Future<RemoteConfigRepository> start() => RemoteConfigService().init();

  @override
  Future<RemoteConfigRepository> init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 10),
    ));

    // await _remoteConfig.fetchAndActivate();

    return this;
  }

  @override
  Future<bool> getBool(String key) async => _remoteConfig.getBool(key);

  @override
  Future<double> getDouble(String key) async => _remoteConfig.getDouble(key);

  @override
  Future<int> getInt(String key) async => _remoteConfig.getInt(key);

  @override
  Future<String> getString(String key) async => _remoteConfig.getString(key);
}
