import 'package:get/get.dart';

import 'configuration_controller.dart';

class ConfigurationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfigurationController(), fenix: true);
  }
}
