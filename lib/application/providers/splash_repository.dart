import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/service/splash_service.dart';
import 'package:ottaa_project_flutter/core/repositories/splash_repository.dart';

class SplashRepositoryImpl  extends ChangeNotifier{
  final SplashRepository splashService;

  SplashRepositoryImpl(this.splashService);
}

final splashProvider = ChangeNotifierProvider<SplashRepositoryImpl>((ref) {
  final SplashRepository splashService = GetIt.I.get<SplashRepository>();
  return SplashRepositoryImpl(splashService);
});
