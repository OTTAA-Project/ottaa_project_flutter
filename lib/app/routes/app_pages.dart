import 'package:get/route_manager.dart';
import 'package:ottaa_project_flutter/app/modules/configuration/configuration_binding.dart';
import 'package:ottaa_project_flutter/app/modules/configuration/configuration_page.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_binding.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_page.dart';
import 'package:ottaa_project_flutter/app/modules/login/login_binding.dart';
import 'package:ottaa_project_flutter/app/modules/login/login_page.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/onboarding_binding.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/onboarding_page.dart';
import 'package:ottaa_project_flutter/app/modules/sentences/sentences_binding.dart';
import 'package:ottaa_project_flutter/app/modules/sentences/sentences_page.dart';
import 'package:ottaa_project_flutter/app/modules/splash/splash_binding.dart';
import 'package:ottaa_project_flutter/app/modules/splash/splash_page.dart';

import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.CONFIGURATION,
      page: () => ConfigurationPage(),
      binding: ConfigurationBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SENTENCES,
      page: () => SentencesPage(),
      binding: SentencesBinding(),
    ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
  ];
}
