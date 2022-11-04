import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:ottaa_project_flutter/core/repositories/tts_repository.dart';

class TTSRepositoryImpl extends ChangeNotifier implements TTSRepository {
  final TTSRepository tts;

  TTSRepositoryImpl(this.tts);

  @override
  Future<void> speak(String text) => tts.speak(text);
}

final ttsProvider = ChangeNotifierProvider<TTSRepositoryImpl>((ref) {
  final tts = GetIt.I<TTSRepository>();
  return TTSRepositoryImpl(tts);
});
