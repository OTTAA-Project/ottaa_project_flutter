import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';
import 'package:ottaa_project_flutter/presentation/screens/login/login_screen.dart';
import 'package:ottaa_project_flutter/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._();

  factory AppRouter() => _instance;

  AppRouter._();

  final GoRouter router = GoRouter(
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
    initialLocation: FirebaseAuth.instance.currentUser == null ? '/login' : '/splash', //Replace with db check
  );
}
