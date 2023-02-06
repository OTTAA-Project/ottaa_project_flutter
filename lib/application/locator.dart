import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/service/service.dart';
import 'package:ottaa_project_flutter/application/use_cases/use_cases.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';
import 'package:ottaa_project_flutter/core/use_cases/use_cases.dart';

final locator = GetIt.instance;

Future<void> setupServices() async {
  final List<Locale> systemLocales = WidgetsBinding.instance.window.locales;
  final List<String> deviceLanguage = Platform.localeName.split('_');
  Locale deviceLocale;
  if (deviceLanguage.length == 2) {
    deviceLocale = Locale(deviceLanguage[0], deviceLanguage[1]);
  } else {
    switch (deviceLanguage[0].toLowerCase()) {
      case 'en':
        deviceLocale = const Locale('en', 'US');
        break;
      case 'it':
        deviceLocale = const Locale('it', 'IT');
        break;
      case 'pt':
        deviceLocale = const Locale('pt', 'BR');
        break;
      case 'es':
      default:
        deviceLocale = const Locale('es', 'AR');
        break;
    }
  }
  print('languages are here:');
  print(deviceLocale);
  final LocalDatabaseRepository databaseRepository = HiveDatabase();
  await databaseRepository.init();

  final ServerRepository serverRepository = ServerService();

  final i18n = await I18N(deviceLocale).init();

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
  final CustomiseRepository customiseServices =
      CustomiseService(serverRepository);

  final CreateEmailToken createEmailToken =
      CreateEmailTokenImpl(serverRepository);
  final VerifyEmailToken verifyEmailToken =
      VerifyEmailTokenImpl(serverRepository);

  final CreateGroupData createGroupData = CreateGroupDataImpl(serverRepository);
  final CreatePictoData createPictoData = CreatePictoDataImpl(serverRepository);
  final CreatePhraseData createPhraseData =
      CreatePhraseDataImpl(serverRepository);

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
  locator.registerSingleton<CustomiseRepository>(customiseServices);
  locator.registerSingleton<CreateEmailToken>(createEmailToken);
  locator.registerSingleton<VerifyEmailToken>(verifyEmailToken);
  locator.registerSingleton<CreateGroupData>(createGroupData);
  locator.registerSingleton<CreatePictoData>(createPictoData);
  locator.registerSingleton<CreatePhraseData>(createPhraseData);
}
