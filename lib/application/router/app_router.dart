import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/presentation/screens/error/error_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/home/home_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/login/login_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/splash/splash_screen.dart';
import 'package:ottaa_project_flutter/presentation/tutorial/tutorial_page.dart';

final AppRouter appRouterSingleton = AppRouter();

class AppRouter {
  String get initialAppResolver {
    final authService = GetIt.I.get<AuthRepository>();

    if (!authService.isLogged) {
      return AppRoutes.login;
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
          builder: (context, state) => const TutorialPage(),
        ),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
      initialLocation: initialAppResolver,
    );
  }
}
