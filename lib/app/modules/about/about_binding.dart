import 'package:get/get.dart';

import 'about_controller.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AboutController(),
    );
  }
}
