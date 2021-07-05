import 'package:get/get.dart';

import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await _init();
  }

  _init() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(AppRoutes.HOME);
  }
}
