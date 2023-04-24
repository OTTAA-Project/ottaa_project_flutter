import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

bool get kIsTablet {
  var mediaQueryData =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  final size = (mediaQueryData.size);

  final diagonal =
      sqrt((size.width * size.width) + (size.height * size.height));

  return diagonal >= 1100.0;
}

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
