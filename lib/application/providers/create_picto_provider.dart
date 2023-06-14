import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePictoProvider extends ChangeNotifier {
  final PageController controller = PageController(initialPage: 0);

  int currentIndex = 0;
  bool isImageSelected = false;
  bool isBoardSelected = false;

  CreatePictoProvider() {
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
    currentIndex = (index ?? 0).toInt();
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

final createPictoProvider = ChangeNotifierProvider<CreatePictoProvider>((ref) {
  return CreatePictoProvider();
});
