import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';

abstract class AuthRepository<U> extends ChangeNotifier {
  FutureOr<Either<String, U>> signIn(SignInType type);

  FutureOr<Either<String, U>> getCurrentUser();

  FutureOr<bool> isLoggedIn();

  FutureOr<void> logout();
}
