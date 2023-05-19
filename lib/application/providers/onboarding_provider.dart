import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingNotifier extends ChangeNotifier {
  final PageController controller = PageController(initialPage: 0);

  double currentIndex = 0;

  OnBoardingNotifier() {
    controller.addListener(setIndex);
  }

  @override
  void dispose() {
    controller.removeListener(setIndex);
    controller.dispose();
    super.dispose();
  }

  setIndex() {
    final index = controller.page;
    currentIndex = (index ?? 0).roundToDouble();
    notifyListeners();
  }

  void nextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void previousPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void goToPage(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}

final onBoardingProvider =
    ChangeNotifierProvider.autoDispose<OnBoardingNotifier>((ref) {
  return OnBoardingNotifier();
});
