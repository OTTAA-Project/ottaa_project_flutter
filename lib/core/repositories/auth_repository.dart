import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, UserModel>> signIn(SignInType type);

  Future<Either<String, UserModel>> getCurrentUser();

  Future<bool> isLoggedIn();

  Future<void> logout();
}
