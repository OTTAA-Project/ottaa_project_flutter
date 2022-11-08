import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/presentation/screens/login/login_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/splash/splash_screen.dart';

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
          path: AppRoutes.login,
          builder: (context, state) => const LoginScreen(),
        ),
      ],
      initialLocation: initialAppResolver,
    );
  }
}
