import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/core/repositories/tts_repository.dart';

class TTSProvider extends ChangeNotifier {
  final TTSRepository tts;

  TTSProvider(this.tts);

  Future<void> speak(String text) => tts.speak(text);
}

final ttsProvider = ChangeNotifierProvider<TTSProvider>((ref) {
  final tts = GetIt.I<TTSRepository>();
  return TTSProvider(tts);
});
