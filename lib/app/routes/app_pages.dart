import 'package:get/route_manager.dart';
import 'package:ottaa_project_flutter/app/modules/about/about_binding.dart';
import 'package:ottaa_project_flutter/app/modules/about/about_ottaa_page.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_binding.dart';
import 'package:ottaa_project_flutter/app/modules/edit_picto/edit_picto_page.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_page.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/add_group_page.dart';
import 'package:ottaa_project_flutter/app/modules/report/report_binding.dart';
import 'package:ottaa_project_flutter/app/modules/report/report_page.dart';
import 'package:ottaa_project_flutter/app/modules/settings/language_page.dart';
import 'package:ottaa_project_flutter/app/modules/settings/settings_binding.dart';
import 'package:ottaa_project_flutter/app/modules/settings/settings_page.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_binding.dart';
import 'package:ottaa_project_flutter/app/modules/home/home_page.dart';
import 'package:ottaa_project_flutter/app/modules/login/login_binding.dart';
import 'package:ottaa_project_flutter/app/modules/login/login_page.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/onboarding_binding.dart';
import 'package:ottaa_project_flutter/app/modules/onboarding/onboarding_page.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_binding.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/pictogram_groups_page.dart';
import 'package:ottaa_project_flutter/app/modules/pictogram_groups/select_picto_page.dart';
import 'package:ottaa_project_flutter/app/modules/sentences/sentences_binding.dart';
import 'package:ottaa_project_flutter/app/modules/sentences/sentences_page.dart';
import 'package:ottaa_project_flutter/app/modules/settings/voice_and_subtitle_page.dart';
import 'package:ottaa_project_flutter/app/modules/splash/splash_binding.dart';
import 'package:ottaa_project_flutter/app/modules/splash/splash_page.dart';
import 'package:ottaa_project_flutter/app/modules/tutorial/tutorial_binding.dart';
import 'package:ottaa_project_flutter/app/modules/tutorial/tutorial_page.dart';
import 'package:ottaa_project_flutter/app/modules/games/games_bindings.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS_LANG,
      page: () => LanguagePage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS_VOICE,
      page: () => VoiceAndSubtitlesPage(),
      binding: SettingsBinding(),
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
    GetPage(
      name: AppRoutes.TUTORIAL,
      page: () => TutorialPage(),
      binding: TutorialBinding(),
    ),
    GetPage(
      name: AppRoutes.PICTOGRAMGROUP,
      page: () => PictogramGroupsPage(),
      binding: PictogramGroupsBinding(),
    ),
    GetPage(
      name: AppRoutes.SELECTPICTO,
      page: () => SelectPictoPage(),
      binding: PictogramGroupsBinding(),
    ),
    GetPage(
      name: AppRoutes.EDITPICTO,
      page: () => EditPictoPage(),
      binding: EditPictoBinding(),
    ),
    GetPage(
      name: AppRoutes.ABOUTOTTAA,
      page: () => AboutOttaaPage(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: AppRoutes.GAMES,
      page: () => GamesPage(),
      binding: GamesBinding(),
    ),
    GetPage(
      name: AppRoutes.ADDGROUP,
      page: () => AddGroupPage(),
    ),
    GetPage(
      name: AppRoutes.REPORTPAGE,
      page: () => ReportPage(),
      binding: ReportBinding(),
    ),
  ];
}
