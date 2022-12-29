import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/service/auth_service.dart';
import 'package:ottaa_project_flutter/application/service/groups_service.dart';
import 'package:ottaa_project_flutter/application/service/local_storage_service.dart';
import 'package:ottaa_project_flutter/application/service/mobile_remote_storage_service.dart';
import 'package:ottaa_project_flutter/application/service/pictograms_service.dart';
import 'package:ottaa_project_flutter/application/service/profile_services.dart';
import 'package:ottaa_project_flutter/application/service/sentences_service.dart';
import 'package:ottaa_project_flutter/application/service/server_service.dart';
import 'package:ottaa_project_flutter/application/service/sql_database.dart';
import 'package:ottaa_project_flutter/application/service/tts_service.dart';
import 'package:ottaa_project_flutter/application/service/web_remote_storage_service.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/profile_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/tts_repository.dart';

import 'service/about_service.dart';

final locator = GetIt.instance;

Future<void> setupServices() async {
  final List<Locale> systemLocales = window.locales;
  final List<String> deviceLanguage = Platform.localeName.split('_');
  Locale deviceLocale;
  if (deviceLanguage.length == 2) {
    deviceLocale = Locale(deviceLanguage[0], deviceLanguage[1]);
  } else {
    deviceLocale = systemLocales.firstWhere(
        (element) => element.languageCode == deviceLanguage[0],
        orElse: () => const Locale('en', 'US'));
  }

  final LocalDatabaseRepository databaseRepository = SqlDatabase();
  await databaseRepository.init();

  final ServerRepository serverRepository = ServerService();

  //todo: change it afterwards
  // final i18n = await I18N(deviceLocale).init();
  final i18n = await I18N(const Locale('en', 'US')).init();

  final AuthRepository authService =
      AuthService(databaseRepository, serverRepository);
  final LocalStorageRepository localStorageService = LocalStorageService();
  late final RemoteStorageRepository remoteStorageService;

  if (kIsWeb) {
    remoteStorageService =
        WebRemoteStorageService(authService, serverRepository, i18n);
  } else {
    remoteStorageService =
        MobileRemoteStorageService(authService, serverRepository, i18n);
  }

  final PictogramsRepository pictogramsService =
      PictogramsService(authService, serverRepository, remoteStorageService);

  final GroupsRepository groupsService =
      GroupsService(authService, remoteStorageService, serverRepository);

  final AboutRepository aboutService =
      AboutService(authService, serverRepository);
  final SentencesRepository sentencesService =
      SentencesService(authService, serverRepository);
  final TTSRepository ttsService = TTSService();
  final ProfileRepository profileServices = ProfileService(serverRepository);

  locator.registerSingleton<I18N>(i18n);
  locator.registerSingleton<LocalDatabaseRepository>(databaseRepository);
  locator.registerSingleton<ServerRepository>(serverRepository);
  locator.registerSingleton<TTSRepository>(ttsService);
  locator.registerSingleton<AuthRepository>(authService);
  locator.registerSingleton<LocalStorageRepository>(localStorageService);
  locator.registerSingleton<RemoteStorageRepository>(remoteStorageService);
  locator.registerSingleton<PictogramsRepository>(pictogramsService);
  locator.registerSingleton<GroupsRepository>(groupsService);
  locator.registerSingleton<AboutRepository>(aboutService);
  locator.registerSingleton<SentencesRepository>(sentencesService);
  locator.registerSingleton<ProfileRepository>(profileServices);
}
