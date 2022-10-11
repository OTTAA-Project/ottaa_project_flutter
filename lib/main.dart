import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:ottaa_project_flutter/application/application.dart';
import 'package:ottaa_project_flutter/application/injector.dart';
import 'package:ottaa_project_flutter/application/service/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    FacebookAuth.i.webInitialize(
      appId: "658779868360186", //<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v9.0",
    );
  }

  await setupServices();

  runApp(const Injector(application: Application()));
}
