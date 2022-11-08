import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/core/repositories/pictograms_repository.dart';

class PictogramsProvider extends ChangeNotifier {
  final PictogramsRepository _pictogramsService;

  PictogramsProvider(this._pictogramsService);
}

final pictogramProvider = ChangeNotifierProvider<PictogramsProvider>((ref) {
  final pictogramService = GetIt.I<PictogramsRepository>();
  return PictogramsProvider(pictogramService);
});
