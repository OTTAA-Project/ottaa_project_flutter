import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/common/extensions/user_extension.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/notifiers/auth_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/patient_notifier.dart';
import 'package:ottaa_project_flutter/application/notifiers/user_notifier.dart';
import 'package:ottaa_project_flutter/application/providers/splash_provider.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/application/router/router_notifier.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_picto_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customized_board_tab_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customized_main_tab_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customized_wait_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/error/error_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/home_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/init/init_screen.dart';
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

final goRouterProvider = Provider<GoRouter>((ref) {
  final routerNotifier = ref.watch(goRouterNotifierProvider);
  return GoRouter(
    restorationScopeId: "ottaa",
    errorBuilder: (context, state) => const ErrorScreen(),
    initialLocation: "/splash",
    refreshListenable: routerNotifier,
    redirect: (context, state) async {
      SplashProvider provider = ref.read(splashProvider);

      final auth = ref.read(authNotifier.notifier);

      bool isLogged = routerNotifier.isLoggedIn;
      bool isFirstTime = await provider.isFirstTime();

      if (await provider.hasUser()) {
        await provider.fetchUserInformation();
        final user = ref.watch(userNotifier);

        auth.setSignedIn();
        I18N.of(context).changeLanguage(user?.settings.language.language ?? "es_AR");
        if (isFirstTime) {
          return AppRoutes.onboarding;
        }

        return null;
      }

      return AppRoutes.login;
    },
    routes: <GoRoute>[
      GoRoute(
        path: "/",
        name: "ottaa",
        builder: (context, state) {
          return const InitScreen();
        },
        routes: [
          GoRoute(
            path: "splash",
            name: "splash",
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: "onboarding",
            name: "onboarding",
            builder: (context, state) {
              int? pageIndex = state.extra as int?;

              return OnBoardingScreen(defaultIndex: pageIndex ?? 0);
            },
          ),
          GoRoute(
            path: "login",
            name: "login",
            builder: (context, state) => const LoginScreen(),
            routes: [
              GoRoute(
                path: "waiting",
                name: "waiting",
                builder: (context, state) => const LoginWaitingScreen(),
              ),
            ],
          ),
          GoRoute(
            path: "home",
            name: "home",
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: "tutorial",
            name: "tutorial",
            builder: (context, state) => const TutorialScreen(),
          ),
          GoRoute(
            path: "report",
            name: "report",
            builder: (context, state) => const ReportScreen(),
          ),
          GoRoute(
            path: "sentences",
            name: "sentences",
            builder: (context, state) => const SentencesScreen(),
          ),
          GoRoute(
            path: "favourite_sentences",
            name: "favourite_sentences",
            builder: (context, state) => const FavouriteScreen(),
          ),
          GoRoute(
            path: "add_or_remove_favourite_sentences",
            name: "add_or_remove_favourite_sentences",
            builder: (context, state) => const AddOrRemoveFavouriteScreen(),
          ),
          GoRoute(
            path: "search_sentences",
            name: "search_sentences",
            builder: (context, state) => const SearchSentenceScreen(),
          ),
          GoRoute(
            path: "profile_waiting_screen",
            name: "profile_waiting_screen",
            builder: (context, state) => const ProfileWaitingScreen(),
          ),
          GoRoute(
            path: "profile_main_screen",
            name: "profile_main_screen",
            builder: (context, state) => const ProfileMainScreen(),
          ),
          GoRoute(
            path: "profile_settings_screen",
            name: "profile_settings_screen",
            builder: (context, state) => const ProfileSettingsScreen(),
          ),
          GoRoute(
            path: "profile_chooser_screen",
            name: "profile_chooser_screen",
            builder: (context, state) => const ProfileChooserScreen(),
          ),
          GoRoute(
            path: "profile_settings_edit_screen",
            name: "profile_settings_edit_screen",
            builder: (context, state) => const ProfileSettingsEditScreen(),
          ),
          GoRoute(
            path: "profile_chooser_screen_selected",
            name: "profile_chooser_screen_selected",
            builder: (context, state) => const ProfileChooserScreenSelected(),
          ),
          GoRoute(
            path: "profile_faq_screen",
            name: "profile_faq_screen",
            builder: (context, state) => const ProfileFAQScreen(),
          ),
          GoRoute(
            path: "profile_help_screen",
            name: "profile_help_screen",
            builder: (context, state) => const ProfileHelpScreen(),
          ),
          GoRoute(
            path: "profile_ottaa_tips_screen",
            name: "profile_ottaa_tips_screen",
            builder: (context, state) => const ProfileOTTAATipsScreen(),
          ),
          GoRoute(
            path: "profile_linked_account_screen",
            name: "profile_linked_account_screen",
            builder: (context, state) => const ProfileLinkedAccountScreen(),
          ),
          GoRoute(
            name: "link",
            path: "link",
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
            path: "customized_board_screen",
            name: "customized_board_screen",
            builder: (context, state) => const CustomizedMainTabScreen(),
          ),
          GoRoute(
            path: "customize_board_screen",
            name: "customize_board_screen",
            builder: (context, state) => const CustomizedBoardTabScreen(),
          ),
          GoRoute(
            path: "customized_wait_screen",
            name: "customized_wait_screen",
            builder: (context, state) => const CustomizeWaitScreen(),
          ),
          GoRoute(
            path: "customized_picto_screen",
            name: "customized_picto_screen",
            builder: (context, state) => const CustomizePictoScreen(),
          ),
          GoRoute(
            path: "profile_main_screen_user",
            name: "xd",
            builder: (context, state) => const ProfileMainScreenUser(),
          ),
          GoRoute(
            path: "setting_screen_user",
            name: "setting_screen_user",
            builder: (context, state) => const SettingScreenUser(),
          ),
          GoRoute(
            path: "accessibility_screen_user",
            name: "accessibility_screen_user",
            builder: (context, state) => const AccessibilityScreen(),
          ),
          GoRoute(
            path: "voice_and_subtitle_screen_user",
            name: "voice_and_subtitle_screen_user",
            builder: (context, state) => const VoiceAndSubtitleScreen(),
          ),
          GoRoute(
            path: "language_screen_user",
            name: "language_screen_user",
            builder: (context, state) => const LanguageScreen(),
          ),
          GoRoute(
            path: "main_setting_screen_user",
            name: "main_setting_screen_user",
            builder: (context, state) => const MainSettingScreen(),
          ),
        ],
      ),
    ],
  );
});
