import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:ottaa_project_flutter/application/router/app_routes.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._();

  factory AppRouter() => _instance;

  AppRouter._();

  final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: AppRoutes.splash,
      ),
      GoRoute(
        path: AppRoutes.home,
      ),
      GoRoute(
        path: AppRoutes.login,
      ),
      GoRoute(
        path: AppRoutes.onboarding,
      ),
      GoRoute(
        path: AppRoutes.sentences,
      ),
      GoRoute(
        path: AppRoutes.settings,
      ),
      GoRoute(
        path: AppRoutes.settingslang,
      ),
      GoRoute(
        path: AppRoutes.settingsvoice,
      ),
      GoRoute(
        path: AppRoutes.tutorial,
      ),
    ],
    initialLocation: FirebaseAuth.instance.currentUser == null ? '/login' : '/splash',
  );
}
