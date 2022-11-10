import 'package:ottaa_project_flutter/core/abstracts/database.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';

abstract class DatabaseRepository implements Database {
  Future<void> setUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> deleteUser();
}
