import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/providers/auth_provider.dart';
import 'package:ottaa_project_flutter/application/providers/user_provider.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customize_picto_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customized_board_tab_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customized_main_tab_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/customized_board/customized_wait_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/error/error_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/game_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/match_pictogram_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/memory_game_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/search_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/select_group_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/games/whats_the_picto_screen.dart';
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
  final authState = ref.read(authProvider.select((value) => value.isUserLoggedIn));
  final userState = ref.watch(userProvider);

  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    restorationScopeId: "ottaa",
    errorBuilder: (context, state) => const ErrorScreen(),
    initialLocation: "/onboarding",
    // refreshListenable: userState,
    routes: <GoRoute>[
      GoRoute(
        path: "/",
        name: "ottaa",
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: "/onboarding",
        name: "onboarding",
        builder: (context, state) {
          int? pageIndex = state.extra as int?;

          return OnBoardingScreen(defaultIndex: pageIndex ?? 0);
        },
      ),
      GoRoute(
        path: "/login",
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
        path: "/tutorial",
        name: "tutorial",
        builder: (context, state) => const TutorialScreen(),
      ),
      GoRoute(
        path: "/home",
        name: "home",
        redirect: (_, __) async {
          bool isLoggedIn = await authState();
          final user = userState.user;
          if (!isLoggedIn) {
            return "/login";
          }

          if (user == null) {
            return '/';
          }
          return null;
        },
        builder: (context, state) {
          final user = userState.user;

          if (user == null) return Container(); //WAiting for the fetching

          switch (user.type) {
            case UserType.caregiver:
              return const ProfileMainScreen();
            case UserType.user:
              return const ProfileMainScreenUser();
            case UserType.none:
              return const ProfileChooserScreen();
          }
        },
        routes: [
          GoRoute(
            path: "loading",
            name: "loading",
            builder: (context, state) => const ProfileWaitingScreen(),
          ),
          GoRoute(
            path: "profile",
            name: "profile",
            builder: (context, state) => const ProfileSettingsScreen(),
            routes: [
              GoRoute(
                path: "role",
                name: "role",
                builder: (context, state) => const ProfileChooserScreenSelected(),
              ),
              GoRoute(
                path: "accounts",
                name: "accounts",
                builder: (context, state) => const ProfileLinkedAccountScreen(),
              ),
              GoRoute(
                path: "tips",
                name: "tips",
                builder: (context, state) => const ProfileOTTAATipsScreen(),
              ),
              GoRoute(
                path: "edit",
                name: "edit",
                builder: (context, state) => const ProfileSettingsEditScreen(),
              ),
              GoRoute(
                path: "help",
                name: "help",
                builder: (context, state) => const ProfileHelpScreen(),
                routes: [
                  GoRoute(
                    path: "faq",
                    name: "faq",
                    builder: (context, state) => const ProfileFAQScreen(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: "customize",
            name: "customize",
            builder: (context, state) => const CustomizedMainTabScreen(),
            routes: [
              GoRoute(
                path: "board",
                name: "board",
                builder: (context, state) => const CustomizedBoardTabScreen(),
              ),
              GoRoute(
                path: "picto",
                name: "picto",
                builder: (context, state) => const CustomizePictoScreen(),
              ),
              GoRoute(
                path: "wait",
                name: "wait",
                builder: (context, state) => const CustomizeWaitScreen(),
              ),
            ],
          ),
          GoRoute(
            path: "talk",
            name: "talk",
            builder: (context, state) => const HomeScreen(),
          ),

          GoRoute(
            path: "account",
            name: "account",
            redirect: (_, __) {
              if (userState.user?.type == UserType.caregiver) {
                return null;
              }

              return "/home";
            },
            builder: (context, state) => const SettingScreenUser(),
            routes: [
              GoRoute(
                path: "layout",
                builder: (context, state) => const MainSettingScreen(),
              ),
              GoRoute(
                path: "accessibility",
                builder: (context, state) => const AccessibilityScreen(),
              ),
              GoRoute(
                path: "tts",
                builder: (context, state) => const VoiceAndSubtitleScreen(),
              ),
              GoRoute(
                path: "language",
                builder: (context, state) => const LanguageScreen(),
              ),
            ],
          ),
          //TODO*: Use ShellRoute instead of GoRoute
          GoRoute(
            path: "link",
            redirect: (_, __) {
              if (userState.user?.type == UserType.caregiver) {
                return null;
              }

              return "/home";
            },
            builder: (context, state) => const LinkMailScreen(),
            routes: [
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
            path: "settings",
            name: "settings",
            redirect: (context, state) {
              if (state.location.startsWith("/home/settings") && userState.user?.type == UserType.caregiver) {
                return "/home";
              }

              return null;
            },
            builder: (context, state) => const SettingScreenUser(),
            routes: [
              GoRoute(
                path: "layout",
                builder: (context, state) => const MainSettingScreen(),
              ),
              GoRoute(
                path: "accessibility",
                builder: (context, state) => const AccessibilityScreen(),
              ),
              GoRoute(
                path: "tts",
                builder: (context, state) => const VoiceAndSubtitleScreen(),
              ),
              GoRoute(
                path: "language",
                builder: (context, state) => const LanguageScreen(),
              ),
            ],
          ),

          GoRoute(
            path: "games",
            name: "games",
            builder: (_, __) => const GameScreen(),
            routes: [
              GoRoute(path: 'groups', builder: (_, __) => const SelectGroupScreen(), routes: [GoRoute(path: 'search', builder: (_, __) => const SearchScreen())]),
              GoRoute(
                path: 'match',
                builder: (_, __) => const MatchPictogramScreen(),
              ),
              GoRoute(
                path: 'memory',
                builder: (_, __) => const MemoryGameScreen(),
              ),
              GoRoute(
                path: 'wtp',
                builder: (_, __) => const WhatsThePictoScreen(),
              ),
            ],
          )
        ],
      ),
    ],
  );
});
