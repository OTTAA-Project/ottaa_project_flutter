import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier() : super(false);

  void showLoading() {
    state = true;
  }

  void hideLoading() {
    state = false;
  }

  void toggleLoading() {
    state = !state;
  }

  bool getState() => state;
}

final loadingProvider = StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier();
});
