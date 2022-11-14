import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';

class AuthNotifier extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(false) {
    state = _authRepository.isLogged;
  }

  void setSignedIn() {
    state = true;
  }

  void setSignedOut() {
    state = false;
  }
}

final authNotifier = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final authService = GetIt.I<AuthRepository>();
  return AuthNotifier(authService);
});
