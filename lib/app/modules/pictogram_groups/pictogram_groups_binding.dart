import 'package:get/get.dart';
import 'pictogram_groups_controller.dart';


class PictogramGroupsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PictogramGroupsController());
  }
}