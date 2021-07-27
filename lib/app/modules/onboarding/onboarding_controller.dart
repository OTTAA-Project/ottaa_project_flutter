import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class OnboardingController extends GetxController {
  final _authController = Get.find<AuthController>();
  AuthController get authController => this._authController;

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await _init();
  }

  _init() async {}
}
