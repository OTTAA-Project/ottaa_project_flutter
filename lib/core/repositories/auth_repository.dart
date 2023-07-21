import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';

abstract class AuthRepository {
  bool get isLogged;

  Future<Either<String, UserModel>> signIn(SignInType type, [String? email, String? password]);

  Future<Either<String, bool>> signUp();

  Future<Either<String, UserModel>> getCurrentUser();

  Future<bool> isLoggedIn();

  Future<void> logout();

  Future<String> getDeviceId();

  Future<bool> deleteAccount({required String userId});
}
