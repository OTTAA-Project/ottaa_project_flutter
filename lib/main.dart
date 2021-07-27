import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/route_manager.dart';
import 'package:ottaa_project_flutter/app/locale/translation.dart';
import 'package:ottaa_project_flutter/app/modules/splash/splash_page.dart';
import 'package:ottaa_project_flutter/app/modules/tutorial/tutorial_binding.dart';

import 'app/modules/splash/splash_binding.dart';
import 'app/modules/tutorial/tutorial_page.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      defaultTransition: Transition.fadeIn,
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
      translations: Translation(), // your translations
      locale:
          Locale('es', 'ES'), // translations will be displayed in that locale
      fallbackLocale: Locale('en', 'US'),
    );
  }
}
