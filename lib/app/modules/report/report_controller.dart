import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';

class ReportController extends GetxController {
  final DataController _dataController = Get.find<DataController>();
  RxString photoUrl = ''.obs;
  RxDouble scorePercentageScore = 0.00.obs;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() async {
    photoUrl.value = await _dataController.fetchUserPhotoUrl();
    super.onInit();
  }
}
