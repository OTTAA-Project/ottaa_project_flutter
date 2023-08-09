abstract class RemoteConfigRepository {
  Future<RemoteConfigRepository> init();

  Future<String?> getString(String key);

  Future<int?> getInt(String key);

  Future<bool?> getBool(String key);

  Future<double?> getDouble(String key);
}
