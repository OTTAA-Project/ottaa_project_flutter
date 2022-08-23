import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/repositories/repositores.dart';
import 'package:ottaa_project_flutter/app/data/service/services.dart';
import 'package:ottaa_project_flutter/app/global_controllers/global_controllers.dart';

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
