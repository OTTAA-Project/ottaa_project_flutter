import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_picto_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customized_main_tab_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customized_wait_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/error/error_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/game_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/select_group_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/home_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/link/link_mail_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/link/link_success_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/link/link_token_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/login/login_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_chooser_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_chooser_screen_selected_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_faq_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_help_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_linked_account_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_main_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_main_screen_user.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_ottaa_tips_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_settings_edit_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_settings_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_waiting_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/report_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/add_or_remove%20_favourites_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/favourites_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/sentences_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/ui/search_sentence.dart';
import 'package:ottaa_project_flutter/presentation/screens/splash/splash_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/tutorial/tutorial_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/accessibility_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/language_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/main_setting_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/setting_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/user_settings/voice_and_subtitle_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/waiting/link_waiting_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/waiting/login_waiting_screen.dart';

final AppRouter appRouterSingleton = AppRouter();

class AppRouter {
  String get initialAppResolver {
    //if (!authService.isLogged) {
    //  return AppRoutes.login;
    //}
    //todo: talk with emir about it
    //if (authService.isLogged) {
    //  return AppRoutes.home;
    //}

    return AppRoutes.splash;
  }

  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.onboarding,
          builder: (context, state) {
            int? pageIndex = state.extra as int?;

            return OnBoardingScreen(defaultIndex: pageIndex ?? 0);
          },
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: "waiting",
              builder: (context, state) => const LoginWaitingScreen(),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.tutorial,
          builder: (context, state) => const TutorialScreen(),
        ),
        GoRoute(
          path: AppRoutes.report,
          builder: (context, state) => const ReportScreen(),
        ),
        GoRoute(
          path: AppRoutes.sentences,
          builder: (context, state) => const SentencesScreen(),
        ),
        GoRoute(
          path: AppRoutes.favouriteSentences,
          builder: (context, state) => const FavouriteScreen(),
        ),
        GoRoute(
          path: AppRoutes.addOrRemoveFavouriteSentences,
          builder: (context, state) => const AddOrRemoveFavouriteScreen(),
        ),
        GoRoute(
          path: AppRoutes.searchSentences,
          builder: (context, state) => const SearchSentenceScreen(),
        ),
        GoRoute(
          path: AppRoutes.profileWaitingScreen,
          builder: (context, state) => const ProfileWaitingScreen(),
        ),
        GoRoute(
          path: AppRoutes.profileMainScreen,
          builder: (context, state) => const ProfileMainScreen(),
        ),
        GoRoute(
          path: AppRoutes.profileSettingsScreen,
          builder: (context, state) => const ProfileSettingsScreen(),
        ),
        GoRoute(
          path: AppRoutes.profileChooserScreen,
          builder: (context, state) => const ProfileChooserScreen(),
        ),
        GoRoute(
          path: AppRoutes.profileSettingsEditScreen,
          builder: (context, state) => const ProfileSettingsEditScreen(),
        ),
        GoRoute(
          path: AppRoutes.profileChooserScreenSelected,
          builder: (context, state) => const ProfileChooserScreenSelected(),
        ),
        GoRoute(
          path: AppRoutes.profileFAQScreen,
          builder: (context, state) => const ProfileFAQScreen(),
        ),
        GoRoute(
          path: AppRoutes.profileHelpScreen,
          builder: (context, state) => const ProfileHelpScreen(),
        ),
        GoRoute(
            path: AppRoutes.profileOttaaTips,
            builder: (context, state) => const ProfileOTTAATipsScreen()),
        GoRoute(
            path: AppRoutes.profileLinkedAccountScreen,
            builder: (context, state) => const ProfileLinkedAccountScreen()),
        GoRoute(
          name: "link",
          path: "/link",
          builder: (context, state) => const SizedBox(),
          routes: [
            GoRoute(
              path: "email",
              builder: (context, state) => const LinkMailScreen(),
            ),
            GoRoute(
              path: "token",
              builder: (context, state) => const LinkTokenScreen(),
            ),
            GoRoute(
              path: "wait",
              builder: (context, state) => const LinkWaitingScreen(),
            ),
            GoRoute(
              path: "success",
              builder: (context, state) => const LinkSuccessScreen(),
            )
          ],
        ),
        GoRoute(
          path: AppRoutes.customizedBoardScreen,
          builder: (context, state) => const CustomizedMainTabScreen(),
        ),
        GoRoute(
          path: AppRoutes.customizeWaitScreen,
          builder: (context, state) => const CustomizeWaitScreen(),
        ),
        GoRoute(
          path: AppRoutes.customizePictoScreen,
          builder: (context, state) => const CustomizePictoScreen(),
        ),
        GoRoute(
          path: AppRoutes.profileMainScreenUser,
          builder: (context, state) => const ProfileMainScreenUser(),
        ),
        GoRoute(
          path: AppRoutes.settingScreenUser,
          builder: (context, state) => const SettingScreenUser(),
        ),
        GoRoute(
          path: AppRoutes.accessibilityScreenUser,
          builder: (context, state) => const AccessibilityScreen(),
        ),
        GoRoute(
          path: AppRoutes.voiceAndSubtitleScreenUser,
          builder: (context, state) => const VoiceAndSubtitleScreen(),
        ),
        GoRoute(
          path: AppRoutes.languageScreenUser,
          builder: (context, state) => const LanguageScreen(),
        ),
        GoRoute(
          path: AppRoutes.mainSettingUser,
          builder: (context, state) => const MainSettingScreen(),
        ),
        GoRoute(
          path: AppRoutes.gameScreen,
          builder: (context, state) => const GameScreen(),
        ),
        GoRoute(
          path: AppRoutes.selectGroupScreen,
          builder: (context, state) => const SelectGroupScreen(),
        ),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
      initialLocation: initialAppResolver,
    );
  }
}
