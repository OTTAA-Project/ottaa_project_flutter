import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PictogramsProvider extends ChangeNotifier {
  PictogramsProvider();
}

final pictogramProvider = ChangeNotifierProvider<PictogramsProvider>((ref) {
  // final pictogramService = GetIt.I<PictogramsRepository>();
  return PictogramsProvider();
});
