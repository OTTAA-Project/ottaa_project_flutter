import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';

class SplashProvider extends ChangeNotifier {
  final AboutRepository _aboutRepository;

  SplashProvider(this._aboutRepository);

  Future<bool> checkUserAvatar() => _aboutRepository.isCurrentUserAvatarExist();
}

final splashProvider = ChangeNotifierProvider<SplashProvider>((ref) {
  final AboutRepository aboutService = GetIt.I.get<AboutRepository>();
  return SplashProvider(aboutService);
});
