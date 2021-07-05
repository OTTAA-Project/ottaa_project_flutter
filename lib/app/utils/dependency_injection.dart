// import 'package:get/get.dart';

import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/data/repositories/sentences_repository.dart';
import 'package:ottaa_project_flutter/app/data/service/sentences_service.dart';

import 'package:ottaa_project_flutter/app/global_controllers/tts_controller.dart';
import 'package:ottaa_project_flutter/app/data/repositories/picts_repository.dart';
import 'package:ottaa_project_flutter/app/data/service/picts_service.dart';

class DependencyInjection {
  static void init() {
    // Global
    Get.lazyPut(() => TTSController(), fenix: true);

    // Repositories
    Get.lazyPut(() => PictsRepository(), fenix: true);
    Get.lazyPut(() => SentencesRepository(), fenix: true);

    // Services
    Get.lazyPut(() => PictsService(), fenix: true);
    Get.lazyPut(() => SentencesService(), fenix: true);
  }
}
