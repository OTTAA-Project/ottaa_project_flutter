import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

class SplashController extends GetxController {
  late bool loggedIn;

  @override
  void onInit() async {
    super.onInit();
    await _init();
  }

  _init() async {
    await firstTime();
    await Future.delayed(Duration(seconds: 1));
    // final User? auth = FirebaseAuth.instance.currentUser;
    if (loggedIn == false) {
      Get.offNamed(AppRoutes.LOGIN);
    } else {
      Get.offNamed(AppRoutes.HOME);
    }
  }

  Future<void> firstTime() async {
    final instance = await SharedPreferences.getInstance();
    loggedIn = instance.getBool('First_time') ?? false;
    print(loggedIn);
  }

  void checkUser() async {}
}
