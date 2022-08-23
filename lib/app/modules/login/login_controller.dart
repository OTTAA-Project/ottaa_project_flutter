import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';

class LoginController extends GetxController {
  final _authController = Get.find<AuthController>();
  AuthController get authController => _authController;

  @override
  void onInit() async {
    super.onInit();
    await _init();
  }

  _init() async {}
}
