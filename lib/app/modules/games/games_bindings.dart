import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_controller.dart';


class GamesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GamesController());
  }
}
