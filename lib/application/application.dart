import 'package:flutter/material.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/locator.dart';
import 'package:ottaa_project_flutter/application/router/app_router.dart';
import 'package:ottaa_project_flutter/core/service/notifications_service.dart';
import 'package:ottaa_ui_kit/theme.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    locator.get<NotificationsService>().onMessageReceived?.onData((data) {
      print(data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return I18nNotifier(
      notifier: getIt.get<I18N>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouterSingleton.router,
        theme: kOttaaLightThemeData,
      ),
    );
  }
}
