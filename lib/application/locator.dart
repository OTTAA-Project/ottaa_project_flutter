import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/service/auth_service.dart';
import 'package:ottaa_project_flutter/application/service/groups_service.dart';
import 'package:ottaa_project_flutter/application/service/local_storage_service.dart';
import 'package:ottaa_project_flutter/application/service/mobile_remote_storage_service.dart';
import 'package:ottaa_project_flutter/application/service/pictograms_service.dart';
import 'package:ottaa_project_flutter/application/service/sentences_service.dart';
import 'package:ottaa_project_flutter/application/service/splash_service.dart';
import 'package:ottaa_project_flutter/application/service/web_remote_storage_service.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/splash_repository.dart';

import 'service/about_service.dart';

final locator = GetIt.instance;

Future<void> setupServices() async {
  final deviceLocale = Intl.getCurrentLocale().split("_")[0];
  final i18n = await I18N(deviceLocale).init();

  final AuthRepository authService = AuthServiceImpl();
  final LocalStorageRepository localStorageService = LocalStorageServiceImpl();
  late final RemoteStorageRepository remoteStorageService;

  if (kIsWeb) {
    remoteStorageService = WebRemoteStorageService(authService, i18n);
  } else {
    remoteStorageService = MobileRemoteStorageService(authService, i18n);
  }

  final PictogramsRepository pictogramsService = PictogramsService(
    authService,
    remoteStorageService,
  );

  final GroupsRepository groupsService = GroupsService(
    authService,
    remoteStorageService,
  );
  final SplashRepository splashService = SplashServiceImpl(
    authService,
  );

  final AboutRepository aboutService = AboutServiceImpl(authService);
  final SentencesRepository sentencesService = SentencesService(authService);

  locator.registerSingleton<I18N>(i18n);
  locator.registerSingleton<AuthRepository>(authService);
  locator.registerSingleton<SplashRepository>(splashService);
  locator.registerSingleton<LocalStorageRepository>(localStorageService);
  locator.registerSingleton<RemoteStorageRepository>(remoteStorageService);
  locator.registerSingleton<PictogramsRepository>(pictogramsService);
  locator.registerSingleton<GroupsRepository>(groupsService);
  locator.registerSingleton<AboutRepository>(aboutService);
  locator.registerSingleton<SentencesRepository>(sentencesService);
}
