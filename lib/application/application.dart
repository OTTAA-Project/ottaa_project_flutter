import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/locator.dart';
import 'package:ottaa_project_flutter/application/router/app_router.dart';
import 'package:ottaa_ui_kit/theme.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return I18nNotifier(
      notifier: locator.get<I18N>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouterSingleton.router,
        theme: kOttaaLightThemeData,
      ),
    );
  }
}
