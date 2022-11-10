import 'package:get/get.dart';

import 'tutorial_controller.dart';

class TutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TutorialController());
  }
}
