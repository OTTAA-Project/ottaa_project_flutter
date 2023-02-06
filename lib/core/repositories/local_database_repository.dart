import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';

abstract class LocalDatabaseRepository {
  UserModel? get user;
  set user(UserModel? user);

  Future<void> init();
  Future<void> close();

  Future<void> setUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> deleteUser();
  Future<bool> getIntro();
  Future<void> setIntro([bool? value]);
}
