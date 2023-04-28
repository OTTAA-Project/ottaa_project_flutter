import 'package:ottaa_project_flutter/core/models/voices_model.dart';

abstract class TTSRepository {
  Future<void> speak(String text);

  Future<List<Voices>> fetchVoices();

  Future<void> changeVoiceSpeed(double speed);

  Future<void> changeCustomTTs(bool value);
  Future<void> changeTTSVoice(String voice);
  Future<void> ttsStop();
}
