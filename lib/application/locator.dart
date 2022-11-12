import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/service/server_service.dart';
import 'package:ottaa_project_flutter/application/service/sql_database.dart';
import 'package:ottaa_project_flutter/application/service/auth_service.dart';
import 'package:ottaa_project_flutter/application/service/groups_service.dart';
import 'package:ottaa_project_flutter/application/service/local_storage_service.dart';
import 'package:ottaa_project_flutter/application/service/mobile_remote_storage_service.dart';
import 'package:ottaa_project_flutter/application/service/pictograms_service.dart';
import 'package:ottaa_project_flutter/application/service/sentences_service.dart';
import 'package:ottaa_project_flutter/application/service/tts_service.dart';
import 'package:ottaa_project_flutter/application/service/web_remote_storage_service.dart';
import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/groups_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/remote_storage_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/tts_repository.dart';
import 'service/about_service.dart';

final locator = GetIt.instance;

Future<void> setupServices() async {
  final deviceLocale = Intl.getCurrentLocale().split("_")[0];

  final LocalDatabaseRepository databaseRepository = SqlDatabase();
  await databaseRepository.init();

  final ServerRepository serverRepository = ServerService();

  final i18n = await I18N(deviceLocale).init();

  final AuthRepository authService = AuthService(databaseRepository, serverRepository);
  final LocalStorageRepository localStorageService = LocalStorageService();
  late final RemoteStorageRepository remoteStorageService;

  if (kIsWeb) {
    remoteStorageService = WebRemoteStorageService(authService, serverRepository, i18n);
  } else {
    remoteStorageService = MobileRemoteStorageService(authService, serverRepository, i18n);
  }

  final PictogramsRepository pictogramsService = PictogramsService(authService, serverRepository, remoteStorageService);

  final GroupsRepository groupsService = GroupsService(authService, remoteStorageService, serverRepository);

  final AboutRepository aboutService = AboutService(authService, serverRepository);
  final SentencesRepository sentencesService = SentencesService(authService, serverRepository);
  final TTSRepository ttsService = TTSService();

  locator.registerSingleton<I18N>(i18n);
  locator.registerSingleton<TTSRepository>(ttsService);
  locator.registerSingleton<AuthRepository>(authService);
  locator.registerSingleton<LocalStorageRepository>(localStorageService);
  locator.registerSingleton<RemoteStorageRepository>(remoteStorageService);
  locator.registerSingleton<PictogramsRepository>(pictogramsService);
  locator.registerSingleton<GroupsRepository>(groupsService);
  locator.registerSingleton<AboutRepository>(aboutService);
  locator.registerSingleton<SentencesRepository>(sentencesService);
}
