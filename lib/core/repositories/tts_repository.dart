import 'package:ottaa_project_flutter/core/models/voices_model.dart';

abstract class TTSRepository {
  get tts;

  bool get customTTSEnable;
  set customTTSEnable(bool value);

  String get language;
  set language(String value);

  List<dynamic> get availableTTS;
  set availableTTS(List<dynamic> value);

  String get voice;
  set voice(String value);

  String get name;
  set name(String value);

  String get locale;
  set locale(String value);

  double get speechRate;

  set speechRate(double value);

  double get pitch;

  set pitch(double value);

  Future<void> speak(String text);

  Future<List<Voices>> fetchVoices();

  Future<void> changeVoiceSpeed(double speed);

  Future<void> changeCustomTTs(bool value);
  Future<void> changeTTSVoice(String voice);
  Future<void> ttsStop();
}
