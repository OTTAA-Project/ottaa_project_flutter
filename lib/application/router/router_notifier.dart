import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoRouterNotifier extends ChangeNotifier {
  bool _isLoggedIn = false;


  bool get isLoggedIn => _isLoggedIn;

  void setLoggedIn() {
    print("Logged In");
    _isLoggedIn = true;
    notifyListeners();
  }

  void setLoggedOut() {
    print("Logged Out");
    _isLoggedIn = false;
    notifyListeners();
  }
}

final goRouterNotifierProvider = Provider<GoRouterNotifier>((ref) {
  return GoRouterNotifier();
});
