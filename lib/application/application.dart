import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/router/app_router.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';
import 'package:ottaa_ui_kit/theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouterSingleton.router,
      theme: kOttaaLightThemeData,
    );
  }
}
