import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/notifiers/auth_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'dart:async';

import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';

class AuthProvider extends ChangeNotifier {
  final LoadingNotifier _loadingNotifier;

  final AuthRepository _authService;
  final AboutRepository _aboutService;
  final LocalDatabaseRepository _localDatabaseRepository;
  final AuthNotifier authData;
  final UserNotifier _userNotifier;

  AuthProvider(
    this._loadingNotifier,
    this._authService,
    this._aboutService,
    this._localDatabaseRepository,
    this.authData,
    this._userNotifier,
  );

  Future<bool> isUserLoggedIn() async {
    return await _authService.isLoggedIn();
  }

  Future<void> logout() async {
    await _authService.logout();
    await _localDatabaseRepository.setIntro(false);
    authData.setSignedOut();
    notifyListeners();

    // _userNotifier.setUser(null);
  }

  Future<Either<String, UserModel>> signIn(SignInType type,
      [String? email, String? password]) async {
    _loadingNotifier.showLoading();

    Either<String, UserModel> result =
        await _authService.signIn(type, email, password);

    if (result.isRight) {
      await _localDatabaseRepository.setUser(result.right);
      //todo: talk with Emir about this and resolve it
      final res = await _aboutService.getUserInformation();
      if (res.isRight) {
        final re = await _authService.runToGetDataFromOtherPlatform(
            email: res.right.email, id: res.right.id);
        debugPrint('here is the result $re');
      }
      _userNotifier.setUser(result.right);
      authData.setSignedIn();
    }

    _loadingNotifier.hideLoading();
    // notifyListeners();
    return result;
  }
}

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  final loadingNotifier = ref.watch(loadingProvider.notifier);

  final AuthRepository authService = GetIt.I.get<AuthRepository>();
  final AboutRepository aboutService = GetIt.I.get<AboutRepository>();
  final LocalDatabaseRepository localDatabaseRepository =
      GetIt.I.get<LocalDatabaseRepository>();

  final AuthNotifier authData = ref.watch(authNotifier.notifier);
  final UserNotifier userState = ref.watch(userProvider);

  return AuthProvider(
    loadingNotifier,
    authService,
    aboutService,
    localDatabaseRepository,
    authData,
    userState,
  );
}, dependencies: [authNotifier, userProvider]);
