import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefClient {
  static SharedPrefClient? _instance;

  SharedPrefClient._internal();

  factory SharedPrefClient() => _instance ??= SharedPrefClient._internal();

  Future<void> setFirstTimePref() async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool('First_time', true);
  }

  Future<void> setPhotoPref() async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool('Avatar_photo', true);
  }

  Future<bool> getPictosFile() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getBool('Pictos_file') ?? false;
  }

  Future<void> setPictosFile() async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool('Pictos_file', true);
  }
}
