import 'package:get/get.dart';

import 'edit_picto_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      EditPictoController(),
    );
  }
}
