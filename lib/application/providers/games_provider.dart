import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamesProvider extends ChangeNotifier {
  int numberOfGroups = 45;
  int completedGroups = 0;
  bool moversMain = true;
  int selectedGame = 0;
  final PageController mainPageController = PageController(initialPage: 0);

  GamesProvider();

  void moveForward() {
    mainPageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    if (mainPageController.page!.toInt() == 1) {
      moversMain = false;
    }
    notifyListeners();
  }

  void moveBackward() {
    mainPageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    if (mainPageController.page!.toInt() == 1) {
      moversMain = true;
    }
    notifyListeners();
  }
}

final gameProvider = ChangeNotifierProvider<GamesProvider>((ref) {
  return GamesProvider();
});
