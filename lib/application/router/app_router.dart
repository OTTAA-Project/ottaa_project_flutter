import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/presentation/screens/error/error_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/home_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/login/login_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_chooser_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_main_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/profile_settings_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/profile/ui/profile_waiting_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/report/report_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/add_or_remove%20_favourites_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/favourites_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/sentences_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/sentences/ui/search_sentence.dart';
import 'package:ottaa_project_flutter/presentation/screens/splash/splash_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/tutorial/tutorial_screen.dart';

final AppRouter appRouterSingleton = AppRouter();

class AppRouter {
  String get initialAppResolver {
    final authService = GetIt.I.get<AuthRepository>();

    if (!authService.isLogged) {
      return AppRoutes.login;
    }
    //todo: talk with emir about it
    if(authService.isLogged){
      return AppRoutes.home;
    }

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
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
      initialLocation: initialAppResolver,
    );
  }
}
