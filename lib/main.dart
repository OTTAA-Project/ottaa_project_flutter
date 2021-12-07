import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:ottaa_project_flutter/app/locale/translation.dart';
import 'package:ottaa_project_flutter/app/modules/splash/splash_page.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
// import 'dart:ui';
import 'app/modules/splash/splash_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DependencyInjection.init();
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    FacebookAuth.i.webInitialize(
      appId: "658779868360186", //<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(Get.deviceLocale);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kOTTAOrangeNew,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      defaultTransition: Transition.fadeIn,
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
      translations: Translation(),
      // your translations
      locale: Get.deviceLocale,
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // translations will be displayed in that locale
      fallbackLocale: Locale('en', 'US'),
    );
  }
}
