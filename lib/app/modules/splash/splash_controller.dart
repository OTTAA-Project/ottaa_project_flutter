import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/onboarding_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

class SplashController extends GetxController {
  late bool loggedIn;
  late bool photo;

  @override
  void onInit() async {
    super.onInit();
    await _init();
  }

  _init() async {
    await firstTime();
    await photoCheck();
    // final User? auth = FirebaseAuth.instance.currentUser;
    if (loggedIn == false) {
      await Future.delayed(
        Duration(seconds: 1),
      );
      Get.offNamed(AppRoutes.LOGIN);
    } else if (photo) {
      await Future.delayed(
        Duration(seconds: 1),
      );
      Get.offNamed(AppRoutes.HOME);
    } else {
      Get.lazyPut(
        () => OnboardingController(),
      );
      Future.delayed(
        Duration(seconds: 1),
      );
      final _controller = Get.find<OnboardingController>();
      _controller.pageNumber.value = 2;
      Get.toNamed(AppRoutes.ONBOARDING);
    }
  }

  Future<void> firstTime() async {
    final instance = await SharedPreferences.getInstance();
    loggedIn = instance.getBool('First_time') ?? false;
    print('the user is logged In or not $loggedIn');
  }

  Future<void> photoCheck() async {
    final instance = await SharedPreferences.getInstance();
    photo = instance.getBool('Avatar_photo') ?? false;
    print(photo);
  }
}
