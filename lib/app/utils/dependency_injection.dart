import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/repositories/firebase_database_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/grupos_repository.dart';
import 'package:ottaa_project_flutter/app/data/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/app/data/service/firebase_database_service.dart';
import 'package:ottaa_project_flutter/app/data/service/grupo_service.dart';
import 'package:ottaa_project_flutter/app/data/service/sentences_service.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/data/service/picts_service.dart';

class DependencyInjection {
  static void init() {
    // Global
    Get.lazyPut(() => TTSController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => DataController(), fenix: true);

    // Repositories
    Get.lazyPut(() => PictsRepository(), fenix: true);
    Get.lazyPut(() => SentencesRepository(), fenix: true);
    Get.lazyPut(() => GrupoRepository(), fenix: true);
    Get.lazyPut(() => FirebaseDatabaseRepository(), fenix: true);

    // Services
    Get.lazyPut(() => PictsService(), fenix: true);
    Get.lazyPut(() => SentencesService(), fenix: true);
    Get.lazyPut(() => GrupoService(), fenix: true);
    Get.lazyPut(() => FirebaseDatabaseService(), fenix: true);
  }
}
