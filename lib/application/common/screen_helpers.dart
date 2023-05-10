import 'package:flutter/services.dart';

Future<void> blockPortraitMode() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

Future<void> blockLandscapeMode() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

Future<void> unblockRotation() async {
  await SystemChrome.setPreferredOrientations([]);
}
