import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/application/locator.dart';
import 'package:ottaa_project_flutter/application/router/app_router.dart';
import 'package:ottaa_ui_kit/theme.dart';

final appRouter = AppRouter.instance.buildRouter();
class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApplicationState();
}

class _ApplicationState extends ConsumerState<Application> {



  @override
  Widget build(BuildContext context) {

    return I18nNotifier(
      notifier: getIt.get<I18N>(),
      child: MaterialApp.router(
        title: "OTTAA Project",
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: kOttaaLightThemeData,
        restorationScopeId: 'root',
      ),
    );
  }
}
