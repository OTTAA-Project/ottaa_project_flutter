import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/router/app_router.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO!: localization, etc.
    return MaterialApp.router(
      routeInformationProvider: AppRouter().router.routeInformationProvider,
      routeInformationParser: AppRouter().router.routeInformationParser,
      routerDelegate: AppRouter().router.routerDelegate,
      routerConfig: AppRouter().router,
      theme: AppTheme.instance.defaultThemeData(),
    );
  }
}
