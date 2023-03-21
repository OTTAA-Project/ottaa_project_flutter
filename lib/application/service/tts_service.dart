import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/repositories/tts_repository.dart';

@Singleton(as: TTSRepository)
class TTSService extends TTSRepository {
  final tts = FlutterTts();
  final I18N _i18n;
  String language = 'es_AR';
  List<dynamic> availableTTS = [];

  bool customTTSEnable = false;

  double speechRate = 0.4;
  double pitch = 1.0;

  TTSService(this._i18n) {
    initTTS();
  }

  @override
  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      if (customTTSEnable) {
        await tts.setLanguage(language);
        await tts.setSpeechRate(speechRate);
        await tts.setPitch(pitch);
      }
      await tts.speak(text);
    }
  }

  Future<void> initTTS() async {
    await tts.setPitch(pitch);
    await tts.setSpeechRate(speechRate);
    await tts.setVolume(1.0);
    await tts.setLanguage(language);
    await tts.awaitSpeakCompletion(true);
    availableTTS = await tts.getLanguages;
  }

  @override
  Future<void> changeVoiceSpeed(double speed)async{
    speechRate = speed;
  }

  @override
  Future<void> fetchVoices(String languageCode) async {
    final voices = await tts.getVoices;
    // print(speechRate);
    // print(voices.toString());
    // print(availableTTS.toString());
  }

  @override
  Future<void> changeCustomTTs(bool value) async{
    customTTSEnable = value;
  }
}
