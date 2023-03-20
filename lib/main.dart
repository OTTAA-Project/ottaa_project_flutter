import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:ottaa_project_flutter/application/application.dart';
import 'package:ottaa_project_flutter/application/injector.dart';
import 'package:ottaa_project_flutter/application/locator.dart';
import 'package:ottaa_project_flutter/application/theme/app_theme.dart';

//March 20v1
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: kOTTAAOrangeNew,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await Firebase.initializeApp();

  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "658779868360186", //<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
  }

  await configureDependencies();

  // await SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeRight,
  //   DeviceOrientation.landscapeLeft,
  // ]);

  runApp(
    const Injector(
      application: Application(),
    ),
  );
}
