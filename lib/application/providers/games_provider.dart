import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamesProvider extends ChangeNotifier {
  int numberOfGroups = 45;
  int completedGroups = 0;
  bool moversMain = true;
  int selectedGame = 0;
  int selectedGroupIndex = 0;
  final PageController mainPageController = PageController(initialPage: 0);
  ScrollController gridScrollController = ScrollController();

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

  void scrollUp() {
    int currentPosition = gridScrollController.position.pixels.toInt();

    if (currentPosition == 0) return;

    gridScrollController.animateTo(
      currentPosition - 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void scrollDown() {
    int currentPosition = gridScrollController.position.pixels.toInt();

    if (currentPosition >= gridScrollController.position.maxScrollExtent)
      return;

    gridScrollController.animateTo(
      currentPosition + 96,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}

final gameProvider = ChangeNotifierProvider<GamesProvider>((ref) {
  return GamesProvider();
});
