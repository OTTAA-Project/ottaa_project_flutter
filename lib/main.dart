
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/route_manager.dart';
import 'package:ottaa_project_flutter/app/locale/translation.dart';
import 'package:ottaa_project_flutter/app/modules/splash/splash_page.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
// import 'dart:ui';
// import 'dart:io';
import 'app/modules/splash/splash_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DependencyInjection.init();
  // final String defaultSystemLocale = Platform.localeName;
  final List<Locale> systemLocales = WidgetsBinding.instance!.window.locales;
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    FacebookAuth.i.webInitialize(
      appId: "658779868360186", //<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
  }
  // print(defaultSystemLocale.toString());
  // print(systemLocales.asMap().toString());
  runApp(MyApp(locale: Locale(systemLocales[0].languageCode,systemLocales[0].languageCode.toUpperCase()),));
}

class MyApp extends StatelessWidget {
  final Locale locale;
  MyApp({required this.locale});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(Get.deviceLocale);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // print('hi i am here ${Platform.localeName.split('_').first}');
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
      locale: locale,
      // translations will be displayed in that locale
      fallbackLocale: Locale('en', 'US'),
    );
  }
}
