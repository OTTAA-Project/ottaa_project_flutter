import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamesProvider extends ChangeNotifier {
  int numberOfGroups = 45;
  int completedGroups = 0;
  final PageController mainPageController = PageController(initialPage: 0);

  GamesProvider();
}

final gameProvider = ChangeNotifierProvider<GamesProvider>((ref) {
  return GamesProvider();
});
