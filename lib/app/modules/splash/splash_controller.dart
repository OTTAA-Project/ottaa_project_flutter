import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await _init();
  }

  _init() async {
    await Future.delayed(Duration(seconds: 1));
    final User? auth = FirebaseAuth.instance.currentUser;
    if (auth == null) {
      Get.offNamed(AppRoutes.LOGIN);
    } else {
      print('hello');
    }
  }

  void checkUser() async {}
}
