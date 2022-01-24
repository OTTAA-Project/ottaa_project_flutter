import 'package:get/get.dart';

import 'edit_picto_controller.dart';

class EditPictoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPictoController());
  }
}
