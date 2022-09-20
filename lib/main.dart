import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/route_manager.dart';
import 'package:ottaa_project_flutter/app/locale/translation.dart';
import 'package:ottaa_project_flutter/app/modules/splash/splash_page.dart';
import 'package:ottaa_project_flutter/app/theme/app_theme.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/modules/splash/splash_binding.dart';
import 'app/routes/app_pages.dart';
import 'package:build_daemon/constants.dart';
import 'app/utils/dependency_injection.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    DependencyInjection.init();
    // final String defaultSystemLocale = Platform.localeName;
    final List<Locale> systemLocales = WidgetsBinding.instance!.window.locales;
    print('these are the locales Asim asked for');
    print(systemLocales.toList());
    print('above it');
    // Pass all uncaught errors from the framework to Crashlytics.
    if (!kIsWeb) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }
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
    final instance = await SharedPreferences.getInstance();
    final String key = instance.getString('Language_KEY') ?? 'Spanish';
    final String languageCode = Constants.LANGUAGE_CODES[key]!;
    final values = languageCode.split('-');
    runApp(
      MyApp(
        locale: key != 'spanish'
            ? Locale(values[0], values[1])
            : Locale('es', 'AR'),
      ),
    );
  }, (error, stackTrace) {
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  });
}

class MyApp extends StatelessWidget {
  final Locale locale;

  MyApp({required this.locale});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // print('hi i am here ${Platform.localeName.split('_').first}');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTTAA PROJECT',
      theme: ThemeData(
        primaryColor: kOTTAAOrangeNew,
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
      fallbackLocale: Locale('es', 'AR'),
    );
  }
}
